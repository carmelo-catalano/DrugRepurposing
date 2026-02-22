BinChenConnectivityScoreListApplyerParallel <- R6Class(
  "BinChenConnectivityScoreListApplyerParallel",
  inherit = BinChenConnectivityScoreListApplyerAbstract,
  public = list(
    initialize = function(drugSignatureLoader = NA) {
      if (!obj_is_na(drugSignatureLoader)) {
        if (!"DrugSignatureLoaderAbstract" %in% class(drugSignatureLoader))
          stop("incompatible parameter type: the class type of drugSignatureLoader must be a subclass of DrugSignatureLoaderAbstract")
        private$drugSignatureLoader <- drugSignatureLoader
      }else {
        private$drugSignatureLoader <- DrugSignatureLoaderByFilename$new()
      }
      private$binChenCMapScoreByDrugDGEWithPValue <- BinChenCMapScoreByDrugDGEWithPValue$new()
    },
    compute = function(disease_signature_down_regulated_genes, disease_signature_up_regulated_genes, drug_signatures, random_connectivity_score_distribution) {
      total_drug_signatures <- dim(drug_signatures)[1]
      processorCores$initCores()
      connectivity_score_matrix <- foreach(i = 1:total_drug_signatures, .combine = rbind) %dopar% {
        drug_signature <- private$drugSignatureLoader$load(drug_signatures$signature_reference[i])
        connectivity_score_with_pvalue <- private$
          binChenCMapScoreByDrugDGEWithPValue$
          compute(disease_signature_down_regulated_genes, disease_signature_up_regulated_genes, drug_signature, random_connectivity_score_distribution)
        data.frame(
          drug = drug_signatures$name[i],
          connectivity_score = connectivity_score_with_pvalue[1],
          p.value = connectivity_score_with_pvalue[2])
      }
      return(connectivity_score_matrix)
    }
  ),
  private = list(
    drugSignatureLoader = NA,
    binChenCMapScoreByDrugDGEWithPValue = NA
  )
)
