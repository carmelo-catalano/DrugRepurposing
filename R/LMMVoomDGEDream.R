LMMVoomDGEDream <- R6Class(
  "LMMVoomDGEDream",
  inherit = LMMVoomDGEAbstract,
  public = list(
    initialize = function() {
      private$lmmVoom <- LMMVoom$new()
      private$dgeMapper <- DGEMapper$new()
      private$geneFilterByProteinCoding <- GeneFilterByProteinCoding$new()
    },
    compute = function(rna_seq_data, rna_seq_metadata, formula, filter_by_protein_coding = FALSE) {
      dgrpLogger$log("start LMM Voom Dream differential gene expression computation")
      startTime <- Sys.time()
      dgrpLogger$log("start dream computation")
      rna_seq_data <- private$
        geneFilterByProteinCoding$
        filterByIdOnCondition(rna_seq_data, filter_by_protein_coding)
      voom_data <- private$lmmVoom$compute(rna_seq_data, rna_seq_metadata, formula)
      partialStartTime <- Sys.time()
      parallelComputationParam <- SnowParam(processorCores$getBPPARAMCores(), "FORK", progressbar = TRUE)
      differential_expression <- dream(voom_data, formula, rna_seq_metadata, BPPARAM = parallelComputationParam)
      totalTime <- Sys.time() - partialStartTime
      dgrpLogger$log(sprintf("end dream computation, time: %s %s", totalTime, attr(totalTime, "units")))
      differential_expression <- variancePartition::eBayes(differential_expression)
      differential_expression <- variancePartition::topTable(differential_expression, coef = 2, number = 10^6)
      differential_expression$std.error <- differential_expression$logFC / differential_expression$t
      differential_expression <- private$dgeMapper$map(differential_expression)
      totalTime <- Sys.time() - startTime
      dgrpLogger$log(sprintf("end LMM Voom Dream differential gene expression computation, time: %s %s", totalTime, attr(totalTime, "units")))
      return(differential_expression)
    }
  ),
  private = list(
    geneFilterByProteinCoding = NA,
    lmmVoom = NA,
    dgeMapper = NA
  )
)
