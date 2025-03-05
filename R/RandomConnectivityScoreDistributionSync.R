RandomConnectivityScoreDistributionSync <- R6Class(
  "RandomConnectivityScoreDistributionSync",
  inherit = RandomConnectivityScoreDistributionAbstract,
  public = list(
    initialize = function() {
      private$binChenCMapScoreByDrugRank <- BinChenCMapScoreByDrugRank$new()
    },
    compute = function(n_disease_signature_down_regulated_genes, n_disease_signature_up_regulated_genes, n_drug_signatures_genes, random_distribution_size) {
      output <- numeric(random_distribution_size)

      for (i in 1:random_distribution_size) {

        drug_signature <- data.frame(
          gene_id = 1:n_drug_signatures_genes,
          rank = sample(1:n_drug_signatures_genes, replace = F)
        )

        DEG_genes <- sample(1:(n_disease_signature_up_regulated_genes + n_disease_signature_down_regulated_genes), replace = F)
        sig_up <- DEG_genes[1:n_disease_signature_up_regulated_genes]
        sig_down <- DEG_genes[(n_disease_signature_up_regulated_genes + 1):length(DEG_genes)]

        output[i] <- private$binChenCMapScoreByDrugRank$compute(
          sig_down,
          sig_up,
          drug_signature
        )
      }
      return(output)
    }
  ),
  private = list(
    binChenCMapScoreByDrugRank = NA
  )
)
