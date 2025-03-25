PValueAndFCThresholdSignature <- R6Class(
  "PValueAndFCThresholdSignature",
  public = list(
    initialize = function() {
      private$diseaseSignatureEstimateMapper <- DiseaseSignatureEstimateMapper$new()
    },
    compute = function(disease_dge, p.value_threshold = 0.001, DE_log2_FC_threshold = 1.5) {
      disease_signature <- subset(disease_dge, disease_dge$adj.p.value <= p.value_threshold & abs(disease_dge$DE_log2_FC) >= DE_log2_FC_threshold)
      return(private$diseaseSignatureEstimateMapper$map(disease_signature))
    }
  ),
  private = list(
    diseaseSignatureEstimateMapper = NA
  )
)