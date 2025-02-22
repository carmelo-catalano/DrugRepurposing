CMapScoreByDrugDGE <- R6Class(
  "CMapScoreByDrugDGE",
  public = list(
    initialize = function() {
      private$cMapScoreByDrugRank <- CMapScoreByDrugRank$new()
    },
    compute = function(disease_signature_down_regulated_genes, disease_signature_up_regulated_genes, drug_signature) {
      drug_signature$rank <- rank(-1 * drug_signature$estimate, ties.method = "random")
      connectivity_score <-
        private$cMapScoreByDrugRank$compute(
          disease_signature_down_regulated_genes,
          disease_signature_up_regulated_genes,
          drug_signature[, c("gene_id", "rank")]
        )
      return(connectivity_score)
    }
  ),
  private = list(
    cMapScoreByDrugRank = NA
  )
)






