LMMNoGeneFilter <- R6Class(
  "LMMNoGeneFilter",
  inherit = LMMGeneFilterAbstract,
  public = list(
    filter = function(gene_expressions, metadata, random_effect_column_names, counts_filter_column_name) {
      return(gene_expressions)
    }
  )
)