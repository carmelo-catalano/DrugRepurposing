library(R6)
library(edgeR)

DiseaseDifferentialExpressionAbstract <- R6Class(
  "DiseaseDifferentialExpressionAbstract",
  public = list(
    compute = function(gene_experiments) {
      stop("I'm an abstract method, implement me")
    }
  )
)