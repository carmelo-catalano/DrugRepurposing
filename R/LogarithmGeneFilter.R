LogarithmGeneFilter <- R6Class(
  "LogarithmGeneFilter",
  inherit = GeneFilterAbstract,
  public = list(
    initialize = function(threshold = 6) {
      private$threshold <- threshold
    },
    filter = function(gene_expressions, sample_statuses = NA) {
      # ci potrebbero essere degli zeri in gene_expressions,
      #  + 1 serve ad evitare errori nel calcolo del logaritmo
      mean <- rowMeans(log(gene_expressions + 1, 2))
      return(gene_expressions[mean > private$threshold,])
    }
  ),
  private = list(
    threshold = NA
  )
)