LMMGeneFilterByLowLevelRandomEffects <- R6Class(
  "LMMGeneFilterByLowLevelRandomEffects",
  public = list(
    initialize = function(random_effects_level_threshold = 5) {
      private$random_effects_level_threshold <- random_effects_level_threshold
    },
    filter = function(rna_data, rna_metadata, random_effect_column_name) {
      filter_column_frequency <- as.data.frame(table(rna_metadata[[random_effect_column_name]]), stringsAsFactors = FALSE)
      filter_column_frequency <- filter_column_frequency[filter_column_frequency$Freq >= private$random_effects_level_threshold,]
      rna_metadata <- rna_metadata[rna_metadata[[random_effect_column_name]] %in% filter_column_frequency$Var1,]
      rna_data <- rna_data[, rna_metadata$sample_id]
      rna_data_metadata <- list()
      rna_data_metadata$rna_data <- rna_data
      rna_data_metadata$rna_metadata <- rna_metadata
      return(rna_data_metadata)
    }
  ),
  private = list(
    random_effects_level_threshold = NA
  )
)
