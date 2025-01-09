library(R6)
library(edgeR)
library(variancePartition)

#source("modules/config.R")
#source("modules/TSRLogger.R")
#source("modules/disease_signature/GeneFilterByProteinCoding.R")

LMMVoomDGE <- R6Class(
  "LMMVoomDGE",
  public = list(
    initialize = function() {
      private$voomDifferentialExpressionMapper <- VoomDifferentialExpressionMapper$new()
    },
    compute = function(rna_seq_data, rna_seq_metadata, formula) {
      data_size <- dim(rna_seq_data)
      dgrpLogger$log(sprintf("start LMM disease signature computation, data size: %s X %s", data_size[1], data_size[2]))
      startTime <- Sys.time()
      dge <- DGEList(rna_seq_data, remove.zeros = TRUE)
      dge <- calcNormFactors(dge, method = 'upperquartile')
      parallelComputationParam <- SnowParam(processorCores$get(), "FORK", progressbar = TRUE)
      dgrpLogger$log("start voomWithDreamWeights computation")
      partialStartTime <- Sys.time()
      voom_data <- voomWithDreamWeights(dge, formula, rna_seq_metadata, BPPARAM = parallelComputationParam)
      totalTime <- Sys.time() - partialStartTime
      dgrpLogger$log(sprintf("end voomWithDreamWeights computation, time: %s %s", totalTime, attr(totalTime, "units")))
      dgrpLogger$log("start dream computation")
      partialStartTime <- Sys.time()
      differential_expression <- dream(voom_data, formula, rna_seq_metadata, BPPARAM = parallelComputationParam)
      totalTime <- Sys.time() - partialStartTime
      dgrpLogger$log(sprintf("end dream computation, time: %s %s", totalTime, attr(totalTime, "units")))
      differential_expression <- variancePartition::eBayes(differential_expression)
      disease_signature <- variancePartition::topTable(differential_expression, coef = 2, number = 10^6)
      disease_signature$std.error <- disease_signature$logFC / disease_signature$t
      totalTime <- Sys.time() - startTime
      dgrpLogger$log(sprintf("end LMM disease signature computation, time: %s %s", totalTime, attr(totalTime, "units")))
      return(private$voomDifferentialExpressionMapper$map(disease_signature))
    }
  ),
  private = list(
    voomDifferentialExpressionMapper = NA
  )
)