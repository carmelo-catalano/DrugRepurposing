
NoGeneFilter <- R6Class(
  "NoGeneFilter",
  inherit = GeneFilterAbstract,
  public = list(
    filter = function(gene_expressions, sample_types) {
      return(gene_expressions)
    }
  )
)