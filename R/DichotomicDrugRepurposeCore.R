DichotomicDrugRepurposeCore <- R6Class(
  "DichotomicDrugRepurposeCore",
  public = list(
    initialize = function(dichotomicCustomTypeDGE, drugSignatureLoader = NA, dgeToSignatureMapper = NA) {
      if (!"DichotomicDGEAbstract" %in% class(dichotomicCustomTypeDGE)) {
        stop("incompatible parameter type: the class type of dichotomicCustomTypeDGE must be a subclass of DichotomicDGEAbstract")
      }
      if (!obj_is_na(drugSignatureLoader)) {
        if (!"DrugSignatureLoaderAbstract" %in% class(drugSignatureLoader))
          stop("incompatible parameter type: the class type of drugSignatureLoader must be a subclass of DrugSignatureLoaderAbstract")
        private$drugSignatureLoader <- drugSignatureLoader
      }else {
        private$drugSignatureLoader <- DrugSignatureLoaderByFilename$new()
      }
      private$dichotomicCustomTypeDGE <- dichotomicCustomTypeDGE
      private$dgeToSignatureMapper <- dgeToSignatureMapper
    },
    compute = function(rna_data, sample_01_map, drugs, drugs_genes, random_distribution_size = 10^5,
                       disease_name = NA, drug_perturbation_time = NA, filter_by_protein_coding = FALSE,
                       parallel_computation = FALSE, signature_mapper_parameter = NA
    ) {
      binChenDiseaseDGEDrugListConnectivityScore <- BinChenDiseaseDGEDrugListConnectivityScore$new(private$drugSignatureLoader, private$dgeToSignatureMapper)
      startTime <- Sys.time()
      dgrpLogger$log("start drug repurposing computation")
      disease_dge <- private$dichotomicCustomTypeDGE$compute(rna_data, sample_01_map, filter_by_protein_coding)
      connectivity_score <- binChenDiseaseDGEDrugListConnectivityScore$compute(
        disease_dge, drugs, drugs_genes, random_distribution_size, disease_name,
        drug_perturbation_time, parallel_computation, signature_mapper_parameter
      )
      totalTime <- Sys.time() - startTime
      dgrpLogger$log(sprintf("end drug repurposing computation, time: %s %s", totalTime, attr(totalTime, "units")))
      return(connectivity_score)
    }
  ),
  private = list(
    dichotomicCustomTypeDGE = NA,
    drugSignatureLoader = NA,
    dgeToSignatureMapper = NA
  )
)
