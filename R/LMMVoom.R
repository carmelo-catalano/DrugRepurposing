LMMVoom <- R6Class(
  "LMMVoom",
  public = list(
    initialize = function() {
      private$geneFilterByProteinCoding <- GeneFilterByProteinCoding$new()
    },
    compute = function(rna_seq_data, rna_seq_metadata, formula, filter_by_protein_coding = F) {
      data_size <- dim(rna_seq_data)
      dgrpLogger$log(sprintf("start voomWithDreamWeights computation, data size: %s X %s", data_size[1], data_size[2]))
      startTime <- Sys.time()
      if (filter_by_protein_coding) {
        rna_seq_data <- private$geneFilterByProteinCoding$filterById(rna_seq_data)
        data_size <- dim(rna_seq_data)
        dgrpLogger$log(sprintf("RNA seq data size after filtering by protein coding genes: %s X %s", data_size[1], data_size[2]))
      }
      dge_list <- DGEList(rna_seq_data, remove.zeros = TRUE)
      dge_list <- calcNormFactors(dge_list, method = 'upperquartile')
      parallelComputationParam <- SnowParam(processorCores$get(), "FORK", progressbar = TRUE)
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
