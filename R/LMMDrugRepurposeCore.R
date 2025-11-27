LMMDrugRepurposeCore <- R6Class(
  "LMMDrugRepurposeCore",
  public = list(
    initialize = function(lmmDGE, drugSignatureLoader = NA, dgeToSignatureMapper = NA) {
      if (!"LMMDGEAbstract" %in% class(lmmDGE) & !"LMMVoomDGEAbstract" %in% class(lmmDGE)) {
        stop("incompatible parameter type: the class type of lmmDGE must be a subclass of LMMDGEAbstract or LMMVoomDGEAbstract")
      }
      private$lmmDGE <- lmmDGE
      private$binChenDiseaseDGEDrugListConnectivityScore <- BinChenDiseaseDGEDrugListConnectivityScore$new(drugSignatureLoader, dgeToSignatureMapper)
    },
    compute = function(rna_data, rna_metadata, formula, drugs, drugs_genes,
                       random_distribution_size = 10^5, disease_name = NA, drug_perturbation_time = NA,
                       parallel_computation = FALSE, filter_by_protein_coding = FALSE,
                       signature_mapper_parameter = NA
    ) {
      startTime <- Sys.time()
      dgrpLogger$log("start drug repurposing computation")
      disease_dge <- private$lmmDGE$compute(rna_data, rna_metadata, formula, filter_by_protein_coding)
      connectivity_score <- private$
        binChenDiseaseDGEDrugListConnectivityScore$
        compute(disease_dge, drugs, drugs_genes, random_distribution_size, disease_name,
                drug_perturbation_time, parallel_computation, signature_mapper_parameter
      )
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
