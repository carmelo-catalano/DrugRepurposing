LINCSGCTXLmerLMMDrugDGE <- R6Class(
  "LINCSGCTXLmerLMMDrugDGE",
  public = list(
    initialize = function(gctx_archive_filename, output_DGE_dir, skip_already_computed_genes = F) {
      lincsMetadataSetuper <- LINCSMetadataSetuper$new()
      lincsGCTXDataLoader <- LINCSGCTXDataLoader$new(gctx_archive_filename)
      lmmDGEByGene <- LMMDGEByGene$new(LmerLMM$new(config$LINCSLMMFormula), LmerLMMToDataFrameMapper$new())
      private$lincsLMMDrugDGE <- LINCSLMMDrugDGE$new(lincsMetadataSetuper, lincsGCTXDataLoader, lmmDGEByGene, output_DGE_dir, skip_already_computed_genes)
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
