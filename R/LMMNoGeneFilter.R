LMMNoGeneFilter <- R6Class(
  "LMMNoGeneFilter",
  inherit = LMMGeneFilterAbstract,
  public = list(
    filter = function(rna_data, rna_metadata, random_effect_column_names, counts_filter_column_name) {
      return(rna_data)
    }
  )
)