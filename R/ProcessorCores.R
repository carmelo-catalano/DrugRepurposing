ProcessorCores <- R6Class(
  "ProcessorCores",
  public = list(
    initialize = function() {
      private$cores <- detectCores()
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
    BPPARAMCores = NA
  )
)

processorCores <- ProcessorCores$new()