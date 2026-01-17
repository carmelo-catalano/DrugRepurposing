RandomConnectivityScoreDistributionParallel <- R6Class(
  "RandomConnectivityScoreDistributionParallel",
  inherit = RandomConnectivityScoreDistributionAbstract,
  public = list(
    initialize = function() {
      private$randomConnectivityScoreDistributionSync <- RandomConnectivityScoreDistributionSync$new()
    },
    compute = function(n_disease_signature_down_regulated_genes, n_disease_signature_up_regulated_genes, n_drug_signatures_genes, random_distribution_size) {
      cores <- processorCores$get()
      if (random_distribution_size < cores) {
        cores <- random_distribution_size
      }
      processorCores$initCores()
      startTime <- Sys.time()
      dgrpLogger$log(paste0("start the random connectivity score computation using ", cores, " CPU cores"))
      block_size <- floor(random_distribution_size / cores)
      first_block_size <- random_distribution_size - block_size * (cores - 1)
      block_sizes <- rep(block_size, cores)
      block_sizes[1] <- first_block_size

      output <- foreach(i = 1:cores, .combine = c) %dopar% {
        private$
          randomConnectivityScoreDistributionSync$
          compute(n_disease_signature_down_regulated_genes, n_disease_signature_up_regulated_genes, n_drug_signatures_genes, block_sizes[i])
      }
      totalTime <- Sys.time() - startTime
      dgrpLogger$log(sprintf("end random connectivity score computation, time: %s %s", totalTime, attr(totalTime, "units")))
      return(output)
    }
  ),
  private = list(
    randomConnectivityScoreDistributionSync = NA
  )
)
