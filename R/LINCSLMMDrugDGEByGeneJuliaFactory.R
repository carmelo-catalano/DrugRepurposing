LINCSLMMDrugDGEByGeneJuliaFactory <- R6Class(
  "LINCSLMMDrugDGEByGeneJuliaFactory",
  public = list(
    initialize = function() {
      private$juliaSetuper <- JuliaSetuper$new()
    },
    create = function(BLAS_num_threads = NA) {
      private$juliaSetuper$setup(BLAS_num_threads)
      lmmJulia <- LMMJulia$new(config$LINCSLMMFormula)
      lmmJuliaToDataFrameMapper <- LMMJuliaToDataFrameMapper$new()
      lmmDGEByGene <- LMMDGEByGene$new(lmmJulia, lmmJuliaToDataFrameMapper)
      return(lmmDGEByGene)
    }
  ),
  private = list(
    juliaSetuper = NA
  )
)