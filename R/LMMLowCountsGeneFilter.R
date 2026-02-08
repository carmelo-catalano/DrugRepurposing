LMMLowCountsGeneFilter <- R6Class(
  "LMMLowCountsGeneFilter",
  inherit = LMMGeneFilterAbstract,
  public = list(
    initialize = function(counts_threshold = 10, random_effects_level_threshold = 5) {
      private$lowCountsGeneFilter <- LowCountsGeneFilter$new(counts_threshold)
      private$lmmGeneFilterByLowLevelRandomEffects <- LMMGeneFilterByLowLevelRandomEffects$new(random_effects_level_threshold)
    },
    filter = function(rna_data, rna_metadata, random_effect_column_name, counts_filter_column_name) {
      rna_data <- private$lowCountsGeneFilter$filter(rna_data, rna_metadata[[counts_filter_column_name]])
      return(private$
               lmmGeneFilterByLowLevelRandomEffects$
               filter(rna_data, rna_metadata, random_effect_column_name))
    }
  ),
  private = list(
    lowCountsGeneFilter = NA,
    lmmGeneFilterByLowLevelRandomEffects = NA
  )
)
