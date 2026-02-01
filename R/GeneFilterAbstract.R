GeneFilterAbstract <- R6Class(
  "GeneFilterAbstract",
  public = list(
    filter = function(gene_expressions, sample_statuses) {
      stop("I'm an abstract method, please implement me")
    }
  )
)