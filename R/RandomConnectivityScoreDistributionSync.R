RandomConnectivityScoreDistributionSync <- R6Class(
  "RandomConnectivityScoreDistributionSync",
  inherit = RandomConnectivityScoreDistributionAbstract,
  public = list(
    initialize = function() {
      private$binChenCMapScoreByDrugRank <- BinChenCMapScoreByDrugRank$new()
    },
    compute = function(n_disease_up_regulated_genes, n_disease_down_regulated_genes, n_drug_signatures_genes, n_permutations) {
      output <- numeric(n_permutations)

      for (i in 1:n_permutations) {

        drug_signature <- data.frame(
          gene_id = 1:n_drug_signatures_genes,
          rank = sample(1:n_drug_signatures_genes, replace = F)
        )

        DEG_genes <- sample(1:(n_disease_up_regulated_genes + n_disease_down_regulated_genes), replace = F)
        sig_up <- DEG_genes[1:n_disease_up_regulated_genes]
        sig_down <- DEG_genes[(n_disease_up_regulated_genes + 1):length(DEG_genes)]

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
