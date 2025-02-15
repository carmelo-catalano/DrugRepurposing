BinChenConnectivityScore <- R6Class(
  "BinChenConnectivityScore",
  public = list(
    initialize = function() {
      private$cMapScore <- CMapScore$new()
    },
    compute = function(disease_signature_down_regulated_genes, disease_signature_up_regulated_genes, drug_signature) {
      drug_signature$rank <- rank(-1 * drug_signature$estimate, ties.method = "random")
      connectivity_score <-
        private$cMapScore$compute(
          disease_signature_down_regulated_genes,
          disease_signature_up_regulated_genes,
          drug_signature[, c("gene_id", "rank")]
        )
      return(connectivity_score)
    }
  ),
  private = list(
    cMapScore = NA
  )
)






