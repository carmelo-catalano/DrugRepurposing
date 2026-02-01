LowCountsGeneFilter <- R6Class(
  "LowCountsGeneFilter",
  inherit = GeneFilterAbstract,
  public = list(
    initialize = function(threshold = 10) {
      private$threshold <- threshold
    },
    filter = function(gene_expressions, sample_statuses) {
      # sample_statuses: Control, Control, Test_sample, Comtol, Test_sample, ...
      # pre-filter low count genes
      # keep genes with at least N counts > private$threshold, where N = size of smallest group
      keep <- rowSums(gene_expressions >= private$threshold) >= min(table(sample_statuses))
      gene_expressions <- gene_expressions[keep,]
      return(gene_expressions)
    }
  ),
  private = list(
    threshold = NA
  )
)