LINCSRDSLMMDrugDGELmer <- R6Class(
  "LINCSRDSLMMDrugDGELmer",
  public = list(
    initialize = function(lincs_splitted_level3_dir, output_dge_dir, skip_already_computed_genes = FALSE) {
      lincsMetadataSetuper <- LINCSMetadataSetuper$new()
      lincsRDSDataLoader <- LINCSRDSDataLoader$new(lincs_splitted_level3_dir)
      lincsLMMDGEByGene <- LINCSLMMDGEByGene$new(LMMLmer$new(config$LINCSLMMFormula), LINCSLMMLmerToDataFrameMapper$new())
      private$lincsLMMDrugDGE <- LINCSLMMDrugDGE$new(lincsMetadataSetuper, lincsRDSDataLoader, lincsLMMDGEByGene, output_dge_dir, skip_already_computed_genes)
    },

    compute = function(drug_perturbation_times, gene_list, drugs_filter = NA) {
      private$lincsLMMDrugDGE$compute(drug_perturbation_times, gene_list, drugs_filter)
      return(NA)
    }
  ),
  private = list(
    lincsLMMDrugDGE = NA
  )
)
