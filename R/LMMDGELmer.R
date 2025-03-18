LMMDGELmer <- R6Class(
  "LMMDGELmer",
  inherit = LMMDGEAbstract,
  public = list(
    initialize = function() {
      private$geneFilterByProteinCoding <- GeneFilterByProteinCoding$new()
      private$lmmLmerToDataFrameMapper <- LMMLmerToDataFrameMapper$new()
    },
    compute = function(rna_data, rna_metadata, formula, filter_by_protein_coding = F) {
      data_size <- dim(rna_data)
      dgrpLogger$log(sprintf("start LMM lmer differential gene expression computation, data size: %s X %s", data_size[1], data_size[2]))
      if (filter_by_protein_coding) {
        rna_data <- private$geneFilterByProteinCoding$filterById(rna_data)
        data_size <- dim(rna_data)
        dgrpLogger$log(sprintf("RNA seq data size after filtering by protein coding genes: %s X %s", data_size[1], data_size[2]))
      }
      startTime <- Sys.time()
      differential_expression <- data.frame()
      data <- rna_metadata
      dependent_variable_name <- "dependet_variable_random_name_a1b"
      lmer_formula <- set_dependent_variable(formula, dependent_variable_name)
      for (i in 1:data_size[1]) {
        data[[dependent_variable_name]] <- as.numeric(rna_data[i,])
        differential_expression <- rbind(differential_expression, private$lmmLmerToDataFrameMapper$map(lmer(lmer_formula, data = data, control = lmerControl(calc.derivs = FALSE)), rownames(rna_data)[i]))
      }
      totalTime <- Sys.time() - startTime
      colnames(differential_expression) <- c("gene_id", "DE_log2_FC", "std.error", "t.value")
      differential_expression <- differential_expression[order(differential_expression$gene_id),]
      dgrpLogger$log(sprintf("end LMM lmer differential gene expression computation, time: %s %s", totalTime, attr(totalTime, "units")))
      return(differential_expression)
    }
  ),
  private = list(
    geneFilterByProteinCoding = NA,
    lmmLmerToDataFrameMapper = NA
  )
)
