LINCSLMMDrugDGEByGeneJuliaFactory <- R6Class(
  "LINCSLMMDrugDGEByGeneJuliaFactory",
  public = list(
    initialize = function() {
      private$juliaSetuper <- JuliaSetuper$new()
    },
    create = function(BLAS_num_threads = NA, LMMFormula = NA) {
      private$juliaSetuper$setup(BLAS_num_threads)
      if (obj_is_na(LMMFormula)){
        lmmJulia <- LMMJulia$new(config$LINCSLMMFormula)
      }else{
        lmmJulia <- LMMJulia$new(LMMFormula)
      }
      lincsLMMJuliaToDataFrameMapper <- LINCSLMMJuliaToDataFrameMapper$new()
      lincsLMMDGEByGene <- LINCSLMMDGEByGene$new(lmmJulia, lincsLMMJuliaToDataFrameMapper)
      return(lincsLMMDGEByGene)
    }
  ),
  private = list(
    juliaSetuper = NA
  )
)