DichotomicDrugRepurposeCore <- R6Class(
  "DichotomicDrugRepurposeCore",
  public = list(
    initialize = function(dichotomicCustomTypeDGE, dgeToSignatureMapper = NA) {
      if (!"DichotomicDGEAbstract" %in% class(dichotomicCustomTypeDGE)) {
        stop("incompatible parameter type: the class type of dichotomicCustomTypeDGE must be a subclass of DichotomicDGEAbstract")
      }
      private$dichotomicCustomTypeDGE <- dichotomicCustomTypeDGE
      private$dgeToSignatureMapper <- dgeToSignatureMapper
    },
    compute = function(rna_data, sample_01_map, drug_dge_dir, drugs, drugs_genes,
                       drug_dge_t_value_column_name = "t.value", random_distribution_size = 10^5,
                       disease_name = NA, drug_perturbation_time = NA, filter_by_protein_coding = FALSE,
                       parallel_computation = FALSE, signature_mapper_parameter = NA
    ) {
      drugSignatureLoaderByDrugName <- DrugSignatureLoaderByDrugName$new(drug_dge_dir, drug_dge_t_value_column_name)
      binChenDiseaseDGEDrugListConnectivityScore <- BinChenDiseaseDGEDrugListConnectivityScore$new(drugSignatureLoaderByDrugName, private$dgeToSignatureMapper)
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
    dgeToSignatureMapper = NA
  )
)
