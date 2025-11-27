LMMVoomDGEAbstract <- R6Class(
  "LMMVoomDGEAbstract",
  public = list(
    initialize = function() {
    },
    compute = function(rna_seq_data, rna_seq_metadata, formula, filter_by_protein_coding = FALSE) {
      stop("I'm an abstract method, please implement me")
    }
  )
)
