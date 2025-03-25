MostSignificantGenesSignature <- R6Class(
  "MostSignificantGenesSignature",
  public = list(
    initialize = function() {
      private$diseaseSignatureEstimateMapper <- DiseaseSignatureEstimateMapper$new()
    },
    compute = function(disease_dge, disease_n_most_significant_genes) {
      disease_dge$abs_t.value <- abs(disease_dge$t.value)
      disease_dge <- disease_dge[order(disease_dge$abs_t.value, decreasing = T),]
      disease_signature <- disease_dge[1:disease_n_most_significant_genes, , drop = FALSE]
      return(private$diseaseSignatureEstimateMapper$map(disease_signature))
    }
  ),
  private = list(
    diseaseSignatureEstimateMapper = NA
  )
)