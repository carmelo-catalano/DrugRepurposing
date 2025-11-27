GEORNASeqLMMVoomDGEDream <- R6Class(
  "GEORNASeqLMMVoomDGEDream",
  inherit = GEORNASeqLMMVoomDGEAbstract,
  public = list(
    initialize = function(geneFilter = NA) {
      private$lmmVoomDGE <- GEORNASeqLMMVoomDGECore$new(LMMVoomDGEDream$new(), geneFilter)
    },
    compute = function(rna_seq_data_filename, rna_seq_metadata_filename, formula, tissue_status_field_name, tissue_statuses_to_be_tested, tissue_statuses_map, sample_id_field_name = "accession", additional_fields = NA, filter_by_protein_coding = FALSE) {
      return(private$lmmVoomDGE$compute(rna_seq_data_filename, rna_seq_metadata_filename, formula, tissue_status_field_name, tissue_statuses_to_be_tested, tissue_statuses_map, sample_id_field_name, additional_fields, filter_by_protein_coding))
    }
  ),
  private = list(
    lmmVoomDGE = NA
  )
)