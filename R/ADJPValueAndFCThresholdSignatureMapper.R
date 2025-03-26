ADJPValueAndFCThresholdSignatureMapper <- R6Class(
  "ADJPValueAndFCThresholdSignatureMapper",
  inherit = DGEToSignatureMapperAbstract,
  public = list(
    initialize = function(adj.p.value_threshold = 0.001, DE_log2_FC_threshold = 1.5) {
      private$adj.p.value_threshold <- adj.p.value_threshold
      private$DE_log2_FC_threshold <- DE_log2_FC_threshold
      private$diseaseSignatureEstimateMapper <- DiseaseSignatureEstimateMapper$new()
    },
    map = function(dge, unused = NA) {
      disease_signature <- subset(dge, dge$adj.p.value <= private$adj.p.value_threshold & abs(dge$DE_log2_FC) >= private$DE_log2_FC_threshold)
      return(private$diseaseSignatureEstimateMapper$map(disease_signature))
    },
    getSignatureType = function() {
      return("Adj.P.Value_And_FC_Threshold")
    }
  ),
  private = list(
    adj.p.value_threshold = NA,
    DE_log2_FC_threshold = NA,
    diseaseSignatureEstimateMapper = NA
  )
)