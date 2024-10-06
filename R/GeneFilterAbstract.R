library(R6)

GeneFilterAbstract <- R6Class(
  "GeneFilterAbstract",
  public = list(
    filter = function(gene_expressions, disease_control_groups) {
      stop("I'm an abstract method, implement me")
    }
  )
)