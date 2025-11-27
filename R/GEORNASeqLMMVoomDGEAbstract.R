GEORNASeqLMMVoomDGEAbstract <- R6Class(
  "GEORNASeqLMMVoomDGEAbstract",
  public = list(
    compute = function(rna_seq_data_filename, rna_seq_metadata_filename, formula, tissue_status_field_name, tissue_statuses_to_be_tested, tissue_statuses_map, sample_id_field_name = "accession", additional_fields = NA, filter_by_protein_coding = FALSE) {
      stop("I'm an abstract method, please implement me")
    }
  )
)
