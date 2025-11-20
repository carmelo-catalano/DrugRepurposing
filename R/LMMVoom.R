LMMVoom <- R6Class(
  "LMMVoom",
  public = list(
    compute = function(rna_seq_data, rna_seq_metadata, formula) {
      data_size <- dim(rna_seq_data)
      dgrpLogger$log(sprintf("start voomWithDreamWeights computation, data size: %s X %s", data_size[1], data_size[2]))
      startTime <- Sys.time()
      dge_list <- DGEList(rna_seq_data, remove.zeros = TRUE)
      dge_list <- calcNormFactors(dge_list, method = 'upperquartile')
      parallelComputationParam <- SnowParam(processorCores$getBPPARAMCores(), "FORK", progressbar = TRUE)
      dgrpLogger$log("start voomWithDreamWeights computation")
      voom_data <- voomWithDreamWeights(dge_list, formula, rna_seq_metadata, BPPARAM = parallelComputationParam)
      totalTime <- Sys.time() - startTime
      dgrpLogger$log(sprintf("end voomWithDreamWeights computation, time: %s %s", totalTime, attr(totalTime, "units")))
      return(voom_data)
    }
  ),
  private = list(
    geneFilterByProteinCoding = NA
  )
)
