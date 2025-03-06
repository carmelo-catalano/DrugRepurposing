BinChenDiseaseDGEDrugListConnectivityScore <- R6Class(
  "BinChenDiseaseDGEDrugListConnectivityScore",
  public = list(
    initialize = function(drugSignatureLoader = NA) {
      private$diseaseSignatureEstimateMapper <- DiseaseSignatureEstimateMapper$new()
      if (!obj_is_na(drugSignatureLoader)) {
        if (!"DrugSignatureLoaderAbstract" %in% class(drugSignatureLoader))
          stop("the drugSignatureLoader instance must by of type DrugSignatureLoaderAbstract")
        private$drugSignatureLoader <- drugSignatureLoader
      }else {
        private$drugSignatureLoader <- DrugSignatureLoaderByFilename$new()
      }
    },
    compute = function(disease_dge, drugs, drugs_genes, disease_n_most_significant_genes, random_distribution_size = 10^5, disease_name = NA, drug_perturbation_time = NA, parallel_computation = F) {
      disease_dge <- subset(disease_dge, disease_dge$gene_id %in% drugs_genes)
      disease_drug_common_genes <- drugs_genes[drugs_genes %in% disease_dge$gene_id]
      private$drugSignatureLoader$init(disease_drug_common_genes)
      disease_dge$abs_t.value <- abs(disease_dge$t.value)
      disease_dge <- disease_dge[order(disease_dge$abs_t.value, decreasing = T),]
      disease_signature <- disease_dge[1:disease_n_most_significant_genes, , drop = FALSE]
      disease_signature <- private$diseaseSignatureEstimateMapper$map(disease_signature)
      if (parallel_computation) {
        diseaseSignatureDrugListCS <- BinChenDiseaseSignatureDrugListConnectivityScoreParallelFacade$new(private$drugSignatureLoader)
      }else {
        diseaseSignatureDrugListCS <- BinChenDiseaseSignatureDrugListConnectivityScoreSyncFacade$new(private$drugSignatureLoader)
      }
      return(diseaseSignatureDrugListCS$compute(disease_signature, drugs, length(disease_drug_common_genes), random_distribution_size, disease_name, paste0(disease_n_most_significant_genes, " MostSignificantGenes"), drug_perturbation_time))
    }
  ),
  private = list(
    diseaseSignatureEstimateMapper = NA,
    drugSignatureLoader = NA
  )
)
