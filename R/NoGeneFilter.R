
NoGeneFilter <- R6Class(
  "NoGeneFilter",
  inherit = GeneFilterAbstract,
  public = list(
    filter = function(gene_expressions, samples) {
      return(gene_expressions)
    }
  )
)