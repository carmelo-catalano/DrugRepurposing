LMMGeneFilterAbstract <- R6Class(
  "LMMGeneFilterAbstract",
  public = list(
    filter = function(rna_data, rna_metadata, random_effect_column_names, sample_status_column_name) {
      stop("I'm an abstract method, please implement me")
    }
  )
)