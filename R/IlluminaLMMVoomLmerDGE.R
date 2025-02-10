IlluminaLMMVoomLmerDGE <- R6Class(
  "IlluminaLMMVoomLmerDGE",
  public = list(
    initialize = function(geneFilter = NA) {
      private$lmmVoomDGE <- IlluminaLMMVoomDGE$new(LMMVoomLmerDGE$new(), geneFilter)
    },
    compute = function(rna_seq_metadata_filename, rna_seq_data_filename, tissue_statuses_to_be_tested, tissue_statuses_map, formula, filter_by_protein_coding = F) {
      return(private$lmmVoomDGE$compute(rna_seq_metadata_filename, rna_seq_data_filename, tissue_statuses_to_be_tested, tissue_statuses_map, formula, filter_by_protein_coding))
    }
  ),
  private = list(
    lmmVoomDGE = NA
  )
)
