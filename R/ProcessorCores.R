ProcessorCores <- R6Class(
  "ProcessorCores",
  public = list(
    initialize = function() {
      private$cores <- detectCores()
      private$juliaCores <- private$cores
      # is_windows_os
      if (Sys.info()[['sysname']] == "Windows")
        private$BPPARAMCores <- 1
      else
        private$BPPARAMCores <- private$cores
    },
    set = function(cores) {
      private$cores <- cores
    },
    get = function() {
      return(private$cores)
    },
    setJuliaCores = function(juliaCores) {
      private$juliaCores <- juliaCores
    },
    getJuliaCores = function() {
      return(private$juliaCores)
    },
    setBPPARAMCores = function(BPPARAMCores) {
      private$BPPARAMCores <- BPPARAMCores
    },
    getBPPARAMCores = function() {
      return(private$BPPARAMCores)
    },
    initCores = function(cores = NA) {
      if (!obj_is_na(cores)) {
        private$cores <- cores
      }
      dgrpLogger$log(sprintf("processor cores: %s", private$cores))
      registerDoParallel(private$cores)
    }
  ),
  private = list(
    cores = NA,
    juliaCores = NA,
    BPPARAMCores = NA
  )
)

processorCores <- ProcessorCores$new()