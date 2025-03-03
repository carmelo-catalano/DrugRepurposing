BinChenConnectivityScoreListApplyerSync <- R6Class(
  "BinChenConnectivityScoreListApplyerSync",
  inherit = BinChenConnectivityScoreListApplyerAbstract,
  public = list(
    initialize = function(drugSignatureLoader = NA) {
      if (!obj_is_na(drugSignatureLoader)) {
        if (!"DrugSignatureLoaderAbstract" %in% class(drugSignatureLoader))
          stop("the drugSignatureLoader instance must by of type DrugSignatureLoaderAbstract")
        private$drugSignatureLoader <- drugSignatureLoader
      }else {
        private$drugSignatureLoader <- DrugSignatureLoaderByFilename$new()
      }
      private$binChenCMapScoreByDrugDGEWithPValue <- BinChenCMapScoreByDrugDGEWithPValue$new()
    },
    compute = function(disease_signature_down_regulated_genes, disease_signature_up_regulated_genes, drugs, random_connectivity_score_distribution) {
      total_drugs <- dim(drugs)[1]
      connectivity_score_matrix <- data.frame()
      for (i in 1:total_drugs) {
        drug_signature <- private$drugSignatureLoader$load(drugs$filename[i])
        connectivity_score_with_pvalue <- private$
          binChenCMapScoreByDrugDGEWithPValue$
          compute(disease_signature_down_regulated_genes, disease_signature_up_regulated_genes, drug_signature, random_connectivity_score_distribution)
        connectivity_score_matrix <- rbind(
          connectivity_score_matrix,
          data.frame(
            drug = drugs$name[i],
            connectivity_score = connectivity_score_with_pvalue[1],
            p.value = connectivity_score_with_pvalue[2]
          )
        )
      }
      return(connectivity_score_matrix)
    }
  ),
  private = list(
    drugSignatureLoader = NA,
    binChenCMapScoreByDrugDGEWithPValue = NA
  )
)
