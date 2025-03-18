LMMDGEAbstract <- R6Class(
  "LMMDGEAbstract",
  public = list(
    compute = function(rna_data, rna_metadata, formula, filter_by_protein_coding = F) {
      stop("I'm an abstract method, please implement me")
    }
  )
)
