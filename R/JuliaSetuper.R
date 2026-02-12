JuliaSetuper <- R6Class(
  "JuliaSetuper",
  public = list(
    setup = function(BLAS_num_threads = NA) {
      if (obj_is_na(BLAS_num_threads))
        BLAS_num_threads <- processorCores$getJuliaCores()
      dgrpLogger$log("julia setup...")
      julia_setup()
      julia_library("MixedModels")
      julia_command(sprintf("BLAS.set_num_threads(%s)", BLAS_num_threads))
      dgrpLogger$log(paste0("set OPENBLAS_NUM_THREADS = ", BLAS_num_threads))
      return(NA)
    }
  )
)