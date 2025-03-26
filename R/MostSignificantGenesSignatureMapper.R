MostSignificantGenesSignatureMapper <- R6Class(
  "MostSignificantGenesSignatureMapper",
  inherit = DGEToSignatureMapperAbstract,
  public = list(
    initialize = function(n_most_significant_genes = 100) {
      private$n_most_significant_genes <- n_most_significant_genes
      private$diseaseSignatureEstimateMapper <- DiseaseSignatureEstimateMapper$new()
    },
    map = function(dge, n_most_significant_genes = NA) {
      if (obj_is_na(n_most_significant_genes)) {
        n_most_significant_genes <- private$n_most_significant_genes
      }
      dge$abs_t.value <- abs(dge$t.value)
      dge <- dge[order(dge$abs_t.value, decreasing = T),]
      disease_signature <- dge[1:n_most_significant_genes, , drop = FALSE]
      return(private$diseaseSignatureEstimateMapper$map(disease_signature))
    },
    getSignatureType = function() {
      return("MostSignificantGenes")
    }
  ),
  private = list(
    n_most_significant_genes = NA,
    diseaseSignatureEstimateMapper = NA
  )
)