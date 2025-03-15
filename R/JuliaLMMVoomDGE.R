JuliaLMMVoomDGE <- R6Class(
  "JuliaLMMVoomDGE",
  inherit = LMMVoomDGEAbstract,
  public = list(
    initialize = function() {
      private$lmmVoom <- LMMVoom$new()
      private$juliaLMMToDataFrameMapper <- JuliaLMMToDataFrameMapper$new()
      private$juliaSetuper <- JuliaSetuper$new()
      private$geneFilterByProteinCoding <- GeneFilterByProteinCoding$new()
    },
    compute = function(rna_seq_data, rna_seq_metadata, formula, filter_by_protein_coding = F) {
      private$juliaSetuper$setup()
      dgrpLogger$log("start LMM Voom Julia differential gene expression computation")
      startTime <- Sys.time()
      rna_seq_data <- private$
        geneFilterByProteinCoding$
        filterByIdOnCondition(rna_seq_data, filter_by_protein_coding)
      voom_data <- private$lmmVoom$compute(rna_seq_data, rna_seq_metadata, formula)
      dgrpLogger$log("start Julia fit computation")
      partialStartTime <- Sys.time()
      rna_data <- rna_seq_metadata
      differential_expression <- data.frame()
      char_formula <- paste(as.character(formula), collapse = "")
      julia_formula <- as.formula(paste0("sample_field_123___", char_formula))
      data_size <- dim(voom_data$E)
      for (i in 1:data_size[1]) {
        rna_data$sample_field_123___ <- as.numeric(voom_data$E[i,])
        dge <- julia_call("fit", julia_eval("LinearMixedModel"), julia_formula, rna_data, REML = T, wts = voom_data$weights[i,])
        differential_expression <- rbind(differential_expression, private$juliaLMMToDataFrameMapper$map(dge, rownames(voom_data$E)[i]))
      }
      totalTime <- Sys.time() - partialStartTime
      dgrpLogger$log(sprintf("end Julia fit computation, time: %s %s", totalTime, attr(totalTime, "units")))
      differential_expression <- differential_expression[order(differential_expression$gene_id),]
      differential_expression$adj.p.value <- p.adjust(differential_expression$p.value, method = "BH")
      totalTime <- Sys.time() - startTime
      dgrpLogger$log(sprintf("end LMM Voom Julia differential gene expression computation, time: %s %s", totalTime, attr(totalTime, "units")))
      return(differential_expression)
    }
  ),
  private = list(
    juliaSetuper = NA,
    geneFilterByProteinCoding = NA,
    lmmVoom = NA,
    juliaLMMToDataFrameMapper = NA
  )
)
