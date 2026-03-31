LINCSGCTXLMMDrugDGELmer <- R6Class(
  "LINCSGCTXLMMDrugDGELmer",
  public = list(
    initialize = function(gctx_archive_filename, output_DGE_dir, skip_already_computed_genes = FALSE) {
      lincsMetadataSetuper <- LINCSMetadataSetuper$new()
      lincsGCTXDataLoader <- LINCSGCTXDataLoader$new(gctx_archive_filename)
      lincsLMMDGEByGene <- LINCSLMMDGEByGene$new(LMMLmer$new(config$LINCSLMMFormula), LINCSLMMLmerToDataFrameMapper$new())
      private$lincsLMMDrugDGE <- LINCSLMMDrugDGE$new(lincsMetadataSetuper, lincsGCTXDataLoader, lincsLMMDGEByGene, output_DGE_dir, skip_already_computed_genes)
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
