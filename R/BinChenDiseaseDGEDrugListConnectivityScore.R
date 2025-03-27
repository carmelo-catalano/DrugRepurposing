BinChenDiseaseDGEDrugListConnectivityScore <- R6Class(
  "BinChenDiseaseDGEDrugListConnectivityScore",
  public = list(
    initialize = function(drugSignatureLoader = NA, dgeToSignatureMapper = NA) {
      if (!obj_is_na(drugSignatureLoader)) {
        if (!"DrugSignatureLoaderAbstract" %in% class(drugSignatureLoader))
          stop("incompatible parameter type: the class type of drugSignatureLoader must be a subclass of DrugSignatureLoaderAbstract")
        private$drugSignatureLoader <- drugSignatureLoader
      }else {
        private$drugSignatureLoader <- DrugSignatureLoaderByFilename$new()
      }
      if (!obj_is_na(dgeToSignatureMapper)) {
        if (!"DGEToSignatureMapperAbstract" %in% class(dgeToSignatureMapper))
          stop("incompatible parameter type: the class type of dgeToSignatureMapper must be a subclass of DGEToSignatureMapperAbstract")
        private$dgeToSignatureMapper <- dgeToSignatureMapper
      }else {
        private$dgeToSignatureMapper <- MostSignificantGenesSignatureMapper$new()
      }
    },
    compute = function(disease_dge, drugs, drugs_genes, random_distribution_size = 10^5,
                       disease_name = NA, drug_perturbation_time = NA,
                       parallel_computation = F, signature_mapper_parameter = NA
    ) {
      disease_dge <- subset(disease_dge, disease_dge$gene_id %in% drugs_genes)
      disease_drug_common_genes <- drugs_genes[drugs_genes %in% disease_dge$gene_id]
      private$drugSignatureLoader$init(disease_drug_common_genes)
      disease_signature <- private$dgeToSignatureMapper$map(disease_dge, signature_mapper_parameter)
      if (parallel_computation) {
        binChenDiseaseSignatureDrugListConnectivityScore <- BinChenDiseaseSignatureDrugListConnectivityScoreParallelFacade$new(private$drugSignatureLoader)
      }else {
        binChenDiseaseSignatureDrugListConnectivityScore <- BinChenDiseaseSignatureDrugListConnectivityScoreSyncFacade$new(private$drugSignatureLoader)
      }
      return(
        binChenDiseaseSignatureDrugListConnectivityScore$compute(
          disease_signature, drugs, length(disease_drug_common_genes), random_distribution_size,
          disease_name, private$dgeToSignatureMapper$getSignatureType(signature_mapper_parameter), drug_perturbation_time
        )
      )
    }
  ),
  private = list(
    drugSignatureLoader = NA,
    dgeToSignatureMapper = NA
  )
)
