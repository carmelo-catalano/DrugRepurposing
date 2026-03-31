LMMLogarithmGeneFilter <- R6Class(
  "LMMLogarithmGeneFilter",
  inherit = LMMGeneFilterAbstract,
  public = list(
    initialize = function(logarithm_threshold = 1.5, random_effects_level_threshold = 5) {
      private$logarithmGeneFilter <- LogarithmGeneFilter$new(logarithm_threshold)
      private$lmmGeneFilterByLowLevelRandomEffects <- LMMGeneFilterByLowLevelRandomEffects$new(random_effects_level_threshold)
    },
    filter = function(rna_data, rna_metadata, random_effect_column_name, sample_status_column_name = NA) {
      rna_data <- private$logarithmGeneFilter$filter(rna_data)
      return(private$lmmGeneFilterByLowLevelRandomEffects$filter(rna_data, rna_metadata, random_effect_column_name))
    }
  ),
  private = list(
    logarithmGeneFilter = NA,
    lmmGeneFilterByLowLevelRandomEffects = NA
  )
)
