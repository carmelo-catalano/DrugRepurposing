LMMDrugRepurpose <- R6Class(
  "LMMDrugRepurpose",
  public = list(
    initialize = function(lmmDGE = NA, drugSignatureLoader = NA, dgeToSignatureMapper = NA) {
      if (!obj_is_na(lmmDGE)) {
        if (!"LMMDGEAbstract" %in% class(lmmDGE))
          stop("incompatible parameter type: the class type of lmmDGE must be a subclass of LMMDGEAbstract")
      }else {
        lmmDGE <- LMMDGEDream$new()
      }
      private$lmmDrugRepurposeCore <- LMMDrugRepurposeCore$new(lmmDGE, drugSignatureLoader, dgeToSignatureMapper)
    },
    compute = function(rna_data, rna_metadata, formula, drugs, drugs_genes,
                       random_distribution_size = 10^5, disease_name = NA, drug_perturbation_time = NA,
                       parallel_computation = F, filter_by_protein_coding = F,
                       signature_mapper_parameter = NA
    ) {
      return(
        private$lmmDrugRepurposeCore$compute(
          rna_data, rna_metadata, formula, drugs, drugs_genes,
          random_distribution_size, disease_name, drug_perturbation_time,
          parallel_computation, filter_by_protein_coding,
          signature_mapper_parameter
        )
      )
    }
  ),
  private = list(
    lmmDrugRepurposeCore = NA
  )
)
