LMMLowCountsGeneFilter <- R6Class(
  "LMMLowCountsGeneFilter",
  inherit = LMMGeneFilterAbstract,
  public = list(
    initialize = function(counts_threshold = 10, random_effects_level_threshold = 5) {
      private$lowCountsGeneFilter <- LowCountsGeneFilter$new(counts_threshold)
      private$lmmGeneFilterByLowLevelRandomEffects <- LMMGeneFilterByLowLevelRandomEffects$new(random_effects_level_threshold)
    },
    filter = function(gene_expressions, metadata, random_effect_column_name, counts_filter_column_name) {
      gene_expressions <- private$lowCountsGeneFilter$filter(gene_expressions, metadata[[counts_filter_column_name]])
      return(private$
               lmmGeneFilterByLowLevelRandomEffects$
               filter(gene_expressions, metadata, random_effect_column_name))
    }
  ),
  private = list(
    lowCountsGeneFilter = NA,
    lmmGeneFilterByLowLevelRandomEffects = NA
  )
)
