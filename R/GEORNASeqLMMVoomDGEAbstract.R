GEORNASeqLMMVoomDGEAbstract <- R6Class(
  "GEORNASeqLMMVoomDGEAbstract",
  public = list(
    compute = function(rna_seq_data_filename, rna_seq_metadata, formula, filter_by_protein_coding = FALSE) {
      stop("I'm an abstract method, please implement me")
    }
  )
)
