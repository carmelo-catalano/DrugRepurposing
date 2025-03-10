LMMAbstract <- R6Class(
  "LMMAbstract",
  public = list(
    compute = function(rna_data_metadata) {
      stop("I'm an abstract method, implement me")
    },
    getFormula = function() {
      stop("I'm an abstract method, implement me")
    }
  )
)