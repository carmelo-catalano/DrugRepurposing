LMMVoomDGELmer <- R6Class(
  "LMMVoomDGELmer",
  inherit = LMMVoomDGEAbstract,
  public = list(
    initialize = function() {
      private$lmmVoom <- LMMVoom$new()
      private$lmmLMerToDataFrameMapper <- LMMLmerToDataFrameMapper$new()
      private$geneFilterByProteinCoding <- GeneFilterByProteinCoding$new()
    },
    compute = function(rna_seq_data, rna_seq_metadata, formula, filter_by_protein_coding = F) {
      dgrpLogger$log("start LMM Voom Lmer differential gene expression computation")
      startTime <- Sys.time()
      rna_seq_data <- private$
        geneFilterByProteinCoding$
        filterByIdOnCondition(rna_seq_data, filter_by_protein_coding)

      voom_data <- private$lmmVoom$compute(rna_seq_data, rna_seq_metadata, formula)
      dgrpLogger$log("start Lmer computation")
      partialStartTime <- Sys.time()
      rna_data <- rna_seq_metadata
      differential_expression <- data.frame()
      data_size <- dim(voom_data$E)
      dependent_variable_name <- "dependet_variable_random_name_a1b"
      lmer_formula <- set_dependent_variable(formula, dependent_variable_name)
      for (i in 1:data_size[1]) {
        rna_data[[dependent_variable_name]] <- as.numeric(voom_data$E[i,])
        dge <- lmer(lmer_formula, rna_data, weights = voom_data$weights[i,], control = lmerControl(calc.derivs = FALSE))
        differential_expression <- rbind(differential_expression, private$lmmLMerToDataFrameMapper$map(dge, rownames(voom_data$E)[i]))
      }
      totalTime <- Sys.time() - partialStartTime
      dgrpLogger$log(sprintf("end Lmer computation, time: %s %s", totalTime, attr(totalTime, "units")))
      colnames(differential_expression) <- c("gene_id", "DE_log2_FC", "std.error", "t.value")
      differential_expression <- differential_expression[order(differential_expression$gene_id),]
      totalTime <- Sys.time() - startTime
      dgrpLogger$log(sprintf("end LMM Voom Lmer differential gene expression computation, time: %s %s", totalTime, attr(totalTime, "units")))
      return(differential_expression)
    }
  ),
  private = list(
    geneFilterByProteinCoding = NA,
    lmmVoom = NA,
    lmmLMerToDataFrameMapper = NA
  )
)
