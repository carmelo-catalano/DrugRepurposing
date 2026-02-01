NoGeneFilter <- R6Class(
  "NoGeneFilter",
  inherit = GeneFilterAbstract,
  public = list(
    filter = function(gene_expressions, sample_statuses) {
      return(gene_expressions)
    }
  )
)