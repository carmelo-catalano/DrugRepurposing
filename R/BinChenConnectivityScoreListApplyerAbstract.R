
BinChenConnectivityScoreListApplyerAbstract <- R6Class(
  "BinChenConnectivityScoreListApplyerAbstract",
  public = list(
    compute = function(disease_signature_down_regulated_genes, disease_signature_up_regulated_genes, drugs, random_connectivity_score_distribution) {
      stop("I'm an abstract method, implement me")
    }
  )
)