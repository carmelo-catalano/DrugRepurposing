
BinChenCMapScoreByDrugDGEWithPValue <- R6Class(
  "BinChenCMapScoreByDrugDGEWithPValue",
  public = list(
    initialize = function() {
      private$binChenCMapScoreByDrugDGE <- BinChenCMapScoreByDrugDGE$new()
      private$connectivityScorePValue <- ConnectivityScorePValue$new()
    },
    compute = function(disease_down_regulated_genes, disease_up_regulated_genes, drug_signature, random_cs_distribution) {
      connectivity_score <- private$binChenCMapScoreByDrugDGE$compute(disease_down_regulated_genes, disease_up_regulated_genes, drug_signature)
      return(c(connectivity_score, private$connectivityScorePValue$compute(connectivity_score, random_cs_distribution)))
    }
  ),
  private = list(
    binChenCMapScoreByDrugDGE = NA,
    connectivityScorePValue = NA
  )
)






