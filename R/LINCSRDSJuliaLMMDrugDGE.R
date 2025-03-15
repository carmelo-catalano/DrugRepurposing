LINCSRDSJuliaLMMDrugDGE <- R6Class(
  "LINCSRDSJuliaLMMDrugDGE",
  public = list(
    initialize = function(lincs_splitted_level3_dir, output_DGE_dir, BLAS_num_threads = NA, skip_already_computed_genes = F) {
      lincsMetadataSetuper <- LINCSMetadataSetuper$new()
      lincsRDSDataLoader <- LINCSRDSDataLoader$new(lincs_splitted_level3_dir)
      lmmDGEByGene <- LINCSJuliaLMMDrugDGEByGeneFactory$new()$create(BLAS_num_threads)
      private$lincsLMMDrugDGE <- LINCSLMMDrugDGE$new(lincsMetadataSetuper, lincsRDSDataLoader, lmmDGEByGene, output_DGE_dir, skip_already_computed_genes)
    },
    compute = function(perturbation_times, gene_list, drugs_filter = NA) {
      private$lincsLMMDrugDGE$compute(perturbation_times, gene_list, drugs_filter)
      return(NA)
    }
  ),
  private = list(
    lincsLMMDrugDGE = NA
  )
)
