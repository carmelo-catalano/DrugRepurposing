LMMDreamDGE <- R6Class(
  "LMMDreamDGE",
  public = list(
    initialize = function() {
      private$geneFilterByProteinCoding <- GeneFilterByProteinCoding$new()
      private$dgeMapper <- DGEMapper$new()
    },
    compute = function(rna_seq_data, rna_seq_metadata, formula, filter_by_protein_coding = F) {
      data_size <- dim(rna_seq_data)
      dgrpLogger$log(sprintf("start Dream LMM differential gene expression computation, data size: %s X %s", data_size[1], data_size[2]))
      if (filter_by_protein_coding) {
        rna_seq_data <- private$geneFilterByProteinCoding$filterById(rna_seq_data)
        data_size <- dim(rna_seq_data)
        dgrpLogger$log(sprintf("RNA seq data size after filtering by protein coding genes: %s X %s", data_size[1], data_size[2]))
      }
      startTime <- Sys.time()
      parallelComputationParam <- SnowParam(processorCores$get(), "FORK", progressbar = TRUE)
      differential_expression <- dream(rna_seq_data, formula, rna_seq_metadata, BPPARAM = parallelComputationParam)
      differential_expression <- variancePartition::eBayes(differential_expression)
      differential_expression <- variancePartition::topTable(differential_expression, coef = 2, number = 10^6)
      differential_expression$std.error <- differential_expression$logFC / differential_expression$t
      totalTime <- Sys.time() - startTime
      dgrpLogger$log(sprintf("end Dream LMM differential gene expression computation, time: %s %s", totalTime, attr(totalTime, "units")))
      return(private$dgeMapper$map(differential_expression))
    }
  ),
  private = list(
    geneFilterByProteinCoding = NA,
    dgeMapper = NA
  )
)
