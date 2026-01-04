LMMDGEDream <- R6Class(
  "LMMDGEDream",
  inherit = LMMDGEAbstract,
  public = list(
    initialize = function(applyEBayes = FALSE) {
      private$geneFilterByProteinCoding <- GeneFilterByProteinCoding$new()
      private$dgeMapper <- DGEMapper$new()
      private$applyEBayes <- applyEBayes
    },
    compute = function(rna_data, rna_metadata, formula, filter_by_protein_coding = FALSE) {
      data_size <- dim(rna_data)
      dgrpLogger$log(sprintf("start Dream LMM differential gene expression computation, data size: %s X %s", data_size[1], data_size[2]))
      if (filter_by_protein_coding) {
        rna_data <- private$geneFilterByProteinCoding$filterById(rna_data)
        data_size <- dim(rna_data)
        dgrpLogger$log(sprintf("RNA seq data size after filtering by protein coding genes: %s X %s", data_size[1], data_size[2]))
      }
      startTime <- Sys.time()
      parallelComputationParam <- SnowParam(processorCores$getBPPARAMCores(), "FORK", progressbar = TRUE)
      differential_expression <- dream(rna_data, formula, rna_metadata, BPPARAM = parallelComputationParam)
      if (private$applyEBayes) {
        differential_expression <- variancePartition::eBayes(differential_expression)
      }
      differential_expression <- variancePartition::topTable(differential_expression, coef = 2, number = 10^6)
      differential_expression$std.error <- differential_expression$logFC / differential_expression$t
      totalTime <- Sys.time() - startTime
      dgrpLogger$log(sprintf("end Dream LMM differential gene expression computation, time: %s %s", totalTime, attr(totalTime, "units")))
      return(private$dgeMapper$map(differential_expression))
    }
  ),
  private = list(
    geneFilterByProteinCoding = NA,
    dgeMapper = NA,
    applyEBayes = NA
  )
)
