UpregulatedGeneFilter <- R6Class(
  "UpregulatedGeneFilter",
  public = list(
    filter = function(signature) {
      upregulated_genes <- subset(signature, estimate > 0)
      upregulated_genes <- upregulated_genes[order(upregulated_genes$estimate, decreasing = TRUE),]
      return(upregulated_genes[, "gene_id", drop = FALSE])
    }
  )
)
