MeanThresholdGeneFilter <- R6Class(
  "MeanThresholdGeneFilter",
  inherit = GeneFilterAbstract,
  public = list(
    initialize = function(threshold = 3) {
      private$threshold <- threshold
    },
    filter = function(gene_expressions, samples) {
      mean <- rowMeans(gene_expressions)
      return(gene_expressions[mean > private$threshold,])
    }
  ),
  private = list(
    threshold = NA
  )
)