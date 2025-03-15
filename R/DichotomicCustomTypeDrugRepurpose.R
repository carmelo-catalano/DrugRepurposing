DichotomicCustomTypeDrugRepurpose <- R6Class(
  "DichotomicCustomTypeDrugRepurpose",
  public = list(
    initialize = function(dichotomicCustomTypeDGE) {
      private$dichotomicCustomTypeDGE <- dichotomicCustomTypeDGE
    },
    compute = function(rna_data, sample_01_map, disease_name,
                       disease_n_most_significant_genes, drug_dge_dir,
                       drugs, drugs_genes, drug_dge_t_value_column_name = "t.value",
                       random_distribution_size = 10^5,
                       drug_perturbation_time = NA, filter_by_protein_coding = F,
                       parallel_computation = F
    ) {
      drugSignatureLoaderByDrugName <- DrugSignatureLoaderByDrugName$new(drug_dge_dir, drug_dge_t_value_column_name)
      binChenDiseaseDGEDrugListConnectivityScore <- BinChenDiseaseDGEDrugListConnectivityScore$new(drugSignatureLoaderByDrugName)
      startTime <- Sys.time()
      dgrpLogger$log("start drug repurposing computation")
      disease_dge <- private$dichotomicCustomTypeDGE$compute(rna_data, sample_01_map, disease_name, filter_by_protein_coding)
      connectivity_score <- binChenDiseaseDGEDrugListConnectivityScore$compute(
        disease_dge, drugs, drugs_genes, disease_n_most_significant_genes, random_distribution_size, disease_name, drug_perturbation_time, parallel_computation)
      totalTime <- Sys.time() - startTime
      dgrpLogger$log(sprintf("end drug repurposing computation, time: %s %s", totalTime, attr(totalTime, "units")))
      return(connectivity_score)
    }
  ),
  private = list(
    dichotomicCustomTypeDGE = NA
  )
)