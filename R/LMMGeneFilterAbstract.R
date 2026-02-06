LMMGeneFilterAbstract <- R6Class(
  "LMMGeneFilterAbstract",
  public = list(
    filter = function(gene_expressions, metadata, random_effect_column_names, counts_filter_column_name) {
      stop("I'm an abstract method, please implement me")
    }
  )
)