LMMVoomJuliaDGE <- R6Class(
  "LMMVoomJuliaDGE",
  public = list(
    initialize = function() {
      private$geneFilterByProteinCoding <- GeneFilterByProteinCoding$new()
      private$juliaLMMToDataFrameMapper <- JuliaLMMToDataFrameMapper$new()
    },
    compute = function(rna_seq_data, rna_seq_metadata, formula, filter_by_protein_coding = F) {
      data_size <- dim(rna_seq_data)
      dgrpLogger$log(sprintf("start LMM Voom differential gene expression computation, data size: %s X %s", data_size[1], data_size[2]))
      if (filter_by_protein_coding) {
        rna_seq_data <- private$geneFilterByProteinCoding$filterById(rna_seq_data)
        data_size <- dim(rna_seq_data)
        dgrpLogger$log(sprintf("RNA seq data size after filtering by protein coding genes: %s X %s", data_size[1], data_size[2]))
      }
      startTime <- Sys.time()
      dge_list <- DGEList(rna_seq_data, remove.zeros = TRUE)
      dge_list <- calcNormFactors(dge_list, method = 'upperquartile')
      parallelComputationParam <- SnowParam(processorCores$get(), "FORK", progressbar = TRUE)
      dgrpLogger$log("start voomWithDreamWeights computation")
      partialStartTime <- Sys.time()
      voom_data <- voomWithDreamWeights(dge_list, formula, rna_seq_metadata, BPPARAM = parallelComputationParam)
      totalTime <- Sys.time() - partialStartTime
      dgrpLogger$log(sprintf("end voomWithDreamWeights computation, time: %s %s", totalTime, attr(totalTime, "units")))
      dgrpLogger$log("start julia fit computation")
      partialStartTime <- Sys.time()
      rna_data <- rna_seq_metadata
      differential_expression <- data.frame()
      char_formula <- paste(as.character(f3), collapse = "")
      julia_formula <- as.formula(paste0("sample_field_123___", char_formula))
      for (i in 1:data_size[1]) {
        rna_data$sample_field_123___ <- as.numeric(voom_data$E[i,])
        dge <- julia_call("fit", julia_eval("LinearMixedModel"), julia_formula, rna_data, REML = T, wts = voom_data$weights[i,])
        differential_expression <- rbind(differential_expression, private$juliaLMMToDataFrameMapper$map(dge, rownames(voom_data$E)[i]))
      }
      totalTime <- Sys.time() - partialStartTime
      dgrpLogger$log(sprintf("end julia fit computation, time: %s %s", totalTime, attr(totalTime, "units")))
      differential_expression <- differential_expression[order(differential_expression$gene_id),]
      differential_expression$adj.p.value <- p.adjust(differential_expression$p.value, method = "BH")
      totalTime <- Sys.time() - startTime
      dgrpLogger$log(sprintf("end LMM Voom differential gene expression computation, time: %s %s", totalTime, attr(totalTime, "units")))
      return(differential_expression)
    }
  ),
  private = list(
    geneFilterByProteinCoding = NA,
    juliaLMMToDataFrameMapper = NA
  )
)
