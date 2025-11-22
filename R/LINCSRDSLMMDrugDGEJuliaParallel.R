LINCSRDSLMMDrugDGEJuliaParallel <- R6Class(
  "LINCSRDSLMMDrugDGEJuliaParallel",
  public = list(
    initialize = function(lincs_splitted_level3_dir, output_DGE_dir, cluster_start_delay = 40, skip_already_computed_genes = F) {
      private$validate_cunstructor_parameters(lincs_splitted_level3_dir, output_DGE_dir, cluster_start_delay, skip_already_computed_genes)
      private$lincs_splitted_level3_dir <- add_slash_to_directory_path(lincs_splitted_level3_dir)
      private$output_DGE_dir <- add_slash_to_directory_path(output_DGE_dir)
      private$cluster_start_delay <- cluster_start_delay
      private$skip_already_computed_genes <- skip_already_computed_genes
    },
    process = function(chunks) {
      num_process <- length(chunks)
      cluster <- makePSOCKcluster(num_process, outfile = "")
      clusterApply(cluster, chunks, private$process_chunk)
      stopCluster(cluster)
    }
  ),
  private = list(
    lincs_splitted_level3_dir = NA,
    output_DGE_dir = NA,
    cluster_start_delay = NA,
    skip_already_computed_genes = NA,

    process_chunk = function(chunk) {
      library("DrugRepurposing")
      private$validate_input_chunk(chunk)
      delay <- (chunk$number - 1) * private$cluster_start_delay
      dgrpLogger$log(sprintf("chunk number %s computation, delay before start: %s", chunk$number, delay))
      Sys.sleep(delay)
      dgrpLogger$log(sprintf("chunk number %s computation setup...", chunk$number))
      lincsRDSLMMDrugDGEJulia <- LINCSRDSLMMDrugDGEJulia$new(private$lincs_splitted_level3_dir, private$output_DGE_dir, chunk$BLAS_num_threads, private$skip_already_computed_genes)
      startTime <- Sys.time()
      dgrpLogger$log(sprintf("start chunk number %s computation ", chunk$number))
      lincsRDSLMMDrugDGEJulia$compute(chunk$perturbation_times, chunk$gene_list, chunk$drugs_filter)
      totalTime <- Sys.time() - startTime
      dgrpLogger$log(sprintf("end chunk number %s computation, time: %s %s", chunk$number, totalTime, attr(totalTime, "units")))
      return(NA)
    },
    validate_cunstructor_parameters = function(lincs_splitted_level3_dir, output_DGE_dir, cluster_start_delay, skip_already_computed_genes) {
      if (obj_is_na_or_NULL(lincs_splitted_level3_dir)) {
        stop("lincs_splitted_level3_dir must be specified")
      }
      if (obj_is_na_or_NULL(output_DGE_dir)) {
        stop("output_DGE_dir must be specified")
      }
      if (!is.numeric(cluster_start_delay) || cluster_start_delay < 0) {
        stop("cluster_start_delay must be an integer greater than 0")
      }
      if (!is.boolean(skip_already_computed_genes)) {
        stop("skip_already_computed_genes must be a boolean")
      }
      return(NA)
    },
    validate_input_chunk = function(chunk) {
      if (!is.numeric(chunk$number) || chunk$number <= 0) {
        stop("chunk$number must be a positive integer")
      }
      if (obj_is_na_or_NULL(chunk$perturbation_times)) {
        stop("chunk$perturbation_times must be specified")
      }
      if (obj_is_na_or_NULL(chunk$gene_list)) {
        stop("chunk$gene_list must be specified")
      }
      if (!is.vector(chunk$gene_list)) {
        stop("chunk$gene_list must be a vector or a list")
      }
      return(NA)
    }
  )
)
