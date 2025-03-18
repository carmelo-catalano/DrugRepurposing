GeneFilterAbstract <- R6Class(
  "GeneFilterAbstract",
  public = list(
    filter = function(gene_expressions, samples) {
      stop("I'm an abstract method, please implement me")
    }
  )
)