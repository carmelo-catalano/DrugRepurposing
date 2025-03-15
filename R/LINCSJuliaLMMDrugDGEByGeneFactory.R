LINCSJuliaLMMDrugDGEByGeneFactory <- R6Class(
  "LINCSJuliaLMMDrugDGEByGeneFactory",
  public = list(
    initialize = function() {
      private$juliaSetuper <- JuliaSetuper$new()
    },
    create = function(BLAS_num_threads = NA) {
      private$juliaSetuper$setup(BLAS_num_threads)
      juliaLMM <- JuliaLMM$new(config$LINCSLMMFormula)
      juliaLMMToDataFrameMapper <- JuliaLMMToDataFrameMapper$new()
      lmmDGEByGene <- LMMDGEByGene$new(juliaLMM, juliaLMMToDataFrameMapper)
      return(lmmDGEByGene)
    }
  ),
  private = list(
    juliaSetuper = NA
  )
)