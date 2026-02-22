DiseaseSignatureEstimateMapper <- R6Class(
  "DiseaseSignatureEstimateMapper",
  public = list(
    map = function(disease_signature) {
      disease_signature <- disease_signature[, c("gene_id", "t.value")]
      colnames(disease_signature)[2] <- "estimate"
      return(disease_signature)
    }
  )
)
