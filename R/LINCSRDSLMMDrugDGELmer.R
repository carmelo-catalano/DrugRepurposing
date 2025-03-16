LINCSRDSLMMDrugDGELmer <- R6Class(
  "LINCSRDSLMMDrugDGELmer",
  public = list(
    initialize = function(lincs_splitted_level3_dir, output_dge_dir, skip_already_computed_genes = F) {
      lincsMetadataSetuper <- LINCSMetadataSetuper$new()
      lincsRDSDataLoader <- LINCSRDSDataLoader$new(lincs_splitted_level3_dir)
      lmmDGEByGene <- LMMDGEByGene$new(LMMLmer$new(config$LINCSLMMFormula), LMMLmerToDataFrameMapper$new())
      private$lincsLMMDrugDGE <- LINCSLMMDrugDGE$new(lincsMetadataSetuper, lincsRDSDataLoader, lmmDGEByGene, output_dge_dir, skip_already_computed_genes)
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
