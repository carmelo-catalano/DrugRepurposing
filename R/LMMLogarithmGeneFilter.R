LMMLogarithmGeneFilter <- R6Class(
  "LMMLogarithmGeneFilter",
  inherit = LMMGeneFilterAbstract,
  public = list(
    initialize = function(logarithm_threshold = 6, random_effects_level_threshold = 5) {
      private$logarithmGeneFilter <- LogarithmGeneFilter$new(logarithm_threshold)
      private$lmmGeneFilterByLowLevelRandomEffects <- LMMGeneFilterByLowLevelRandomEffects$new(random_effects_level_threshold)
    },
    filter = function(gene_expressions, metadata, random_effect_column_name, counts_filter_column_name = NA) {
      gene_expressions <- logarithmGeneFilter$filter(gene_expressions)
      return(private$lmmGeneFilterByLowLevelRandomEffects(gene_expressions, metadata, random_effect_column_name))
    }
  ),
  private = list(
    logarithmGeneFilter = NA,
    lmmGeneFilterByLowLevelRandomEffects = NA
  )
)