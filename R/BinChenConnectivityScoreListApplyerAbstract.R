
BinChenConnectivityScoreListApplyerAbstract <- R6Class(
  "BinChenConnectivityScoreListApplyerAbstract",
  public = list(
    compute = function(disease_down_regulated_genes, disease_up_regulated_genes, drugs, random_connectivity_score) {
      stop("I'm an abstract method, implement me")
    }
  )
)