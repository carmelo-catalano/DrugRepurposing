LMMDrugRepurpose <- R6Class(
  "LMMDrugRepurpose",
  public = list(
    initialize = function(lmmDGE =NA, drugSignatureLoader = NA) {
      if (!obj_is_na(lmmDGE)) {
        if (!"LMMDGEAbstract" %in% class(lmmDGE))
          stop("incompatible parameter type: the class type of lmmDGE must be a subclass of LMMDGEAbstract")
      }else {
        lmmDGE <- LMMDGEDream$new()
      }
      if (!obj_is_na(drugSignatureLoader)) {
        if (!"DrugSignatureLoaderAbstract" %in% class(drugSignatureLoader))
          stop("incompatible parameter type: the class type of drugSignatureLoader must be a subclass of DrugSignatureLoaderAbstract")
      }else {
        drugSignatureLoader <- DrugSignatureLoaderByFilename$new()
      }
      private$lmmDGE <- lmmDGE
      private$binChenDiseaseDGEDrugListConnectivityScore <- BinChenDiseaseDGEDrugListConnectivityScore$new(drugSignatureLoader)
    },
    compute = function(rna_data, rna_metadata,
                       formula, disease_name, disease_n_most_significant_genes,
                       drugs, drugs_genes, random_distribution_size = 10^5,
                       drug_perturbation_time = NA, parallel_computation = F,
                       filter_by_protein_coding = F
    ) {
      startTime <- Sys.time()
      dgrpLogger$log("start drug repurposing computation")
      disease_dge <- private$lmmDGE$compute(rna_data, rna_metadata, formula, filter_by_protein_coding)
      connectivity_score <- private$
        binChenDiseaseDGEDrugListConnectivityScore$
        compute(disease_dge, drugs, drugs_genes, disease_n_most_significant_genes,
                random_distribution_size, disease_name, drug_perturbation_time,
                parallel_computation)
      totalTime <- Sys.time() - startTime
      dgrpLogger$log(sprintf("end drug repurposing computation, time: %s %s", totalTime, attr(totalTime, "units")))
      return(connectivity_score)
    }
  ),
  private = list(
    lmmDGE = NA,
    binChenDiseaseDGEDrugListConnectivityScore = NA
  )
)
