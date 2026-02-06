LMMGeneFilterByLowLevelRandomEffects <- R6Class(
  "LMMGeneFilterByLowLevelRandomEffects",
  public = list(
    initialize = function(random_effects_level_threshold = 5) {
      private$random_effects_level_threshold <- random_effects_level_threshold
    },
    filter = function(gene_expressions, metadata, random_effect_column_name) {
      filter_column_frequency <- as.data.frame(table(metadata[[random_effect_column_name]]), stringsAsFactors = FALSE)
      filter_column_frequency <- filter_column_frequency[filter_column_frequency$Freq >= private$random_effects_level_threshold,]
      metadata <- metadata[metadata[[random_effect_column_name]] %in% filter_column_frequency$Var1,]
      gene_expressions <- gene_expressions[, metadata$sample_id]
      return(gene_expressions)
    }
  ),
  private = list(
    random_effects_level_threshold = NA
  )
)
