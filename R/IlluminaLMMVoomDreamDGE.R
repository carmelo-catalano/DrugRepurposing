IlluminaLMMVoomDreamDGE <- R6Class(
  "IlluminaLMMVoomDreamDGE",
  public = list(
    initialize = function(geneFilter = NA) {
      private$lmmVoomDGE <- IlluminaLMMVoomDGE$new(LMMVoomDreamDGE$new(), geneFilter)
    },
    compute = function(rna_seq_metadata_filename, rna_seq_data_filename, formula, tissue_status_field_name, tissue_statuses_to_be_tested, tissue_statuses_map, sample_id_field_name = "accession", additional_fields = FA, filter_by_protein_coding = F) {
      return(private$lmmVoomDGE$compute(rna_seq_metadata_filename, rna_seq_data_filename, formula, tissue_status_field_name, tissue_statuses_to_be_tested, tissue_statuses_map, sample_id_field_name, additional_fields, filter_by_protein_coding))
    }
  ),
  private = list(
    lmmVoomDGE = NA
  )
)