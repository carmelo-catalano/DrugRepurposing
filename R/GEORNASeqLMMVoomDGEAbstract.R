GEORNASeqLMMVoomDGEAbstract <- R6Class(
  "GEORNASeqLMMVoomDGEAbstract",
  public = list(
    compute = function(rna_seq_data_filename, rna_seq_metadata, formula, random_effect_column_names, sample_status_column_name, filter_by_protein_coding) {
      stop("I'm an abstract method, please implement me")
    }
  )
)
