LmerLMMVoomDGE <- R6Class(
  "LmerLMMVoomDGE",
  inherit = LMMVoomDGEAbstract,
  public = list(
    initialize = function() {
      private$lmmVoom <- LMMVoom$new()
      private$lmerLMMToDataFrameMapper <- LmerLMMToDataFrameMapper$new()
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
      char_formula <- paste(as.character(formula), collapse = "")
      lmer_formula <- as.formula(paste0("sample_field_123___", char_formula))
      data_size <- dim(voom_data$E)
      for (i in 1:data_size[1]) {
        rna_data$sample_field_123___ <- as.numeric(voom_data$E[i,])
        dge <- lmer(lmer_formula, rna_data, weights = voom_data$weights[i,], control = lmerControl(calc.derivs = FALSE))
        differential_expression <- rbind(differential_expression, private$lmerLMMToDataFrameMapper$map(dge, rownames(voom_data$E)[i]))
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
    lmerLMMToDataFrameMapper = NA
  )
)
