RandomConnectivityScoreDistributionAbstract <- R6Class(
  "RandomConnectivityScoreDistributionAbstract",
  public = list(
    compute = function(n_disease_signature_down_regulated_genes, n_disease_signature_up_regulated_genes, n_drug_signatures_genes, random_distribution_size) {
      stop("I'm an abstract method, please implement me")
    }
  )
)
