LMMVoomDrugRepurpose <- R6Class(
  "LMMVoomDrugRepurpose",
  public = list(
    initialize = function(lmmVoomDGE = NA, drugSignatureLoader = NA) {
      if (!obj_is_na(lmmVoomDGE)) {
        if (!"LMMVoomDGEAbstract" %in% class(lmmVoomDGE))
          stop("the lmmVoomDGE instance must by of type LMMVoomDGEAbstract")
        private$lmmVoomDGE <- lmmVoomDGE
      }else {
        private$lmmVoomDGE <- LMMVoomDGEDream$new()
      }
      if (!obj_is_na(drugSignatureLoader)) {
        if (!"DrugSignatureLoaderAbstract" %in% class(drugSignatureLoader))
          stop("the lmmVoomDGE instance must by of type LMMVoomDGEAbstract")
      }else {
        drugSignatureLoader <- DrugSignatureLoaderByFilename$new()
      }
      private$binChenDiseaseDGEDrugListConnectivityScore <- BinChenDiseaseDGEDrugListConnectivityScore$new(drugSignatureLoader)
    },
    compute = function(rna_seq_data, rna_seq_metadata,
                       formula, disease_name, disease_n_most_significant_genes,
                       drugs, drugs_genes, random_distribution_size = 10^5,
                       drug_perturbation_time = NA, parallel_computation = F,
                       filter_by_protein_coding = F
    ) {
      startTime <- Sys.time()
      dgrpLogger$log("start drug repurposing computation")
      disease_dge <-private$lmmVoomDGE$compute(rna_seq_data, rna_seq_metadata, formula, filter_by_protein_coding)
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
    lmmVoomDGE = NA,
    binChenDiseaseDGEDrugListConnectivityScore = NA
  )
)
