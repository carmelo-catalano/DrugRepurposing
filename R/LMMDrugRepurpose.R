LMMDrugRepurpose <- R6Class(
  "LMMDrugRepurpose",
  public = list(
    initialize = function(lmmDGE = NA, drugSignatureLoader = NA) {
      if (!obj_is_na(lmmDGE)) {
        if (!"LMMDGEAbstract" %in% class(lmmDGE))
          stop("incompatible parameter type: the class type of lmmDGE must be a subclass of LMMDGEAbstract")
      }else {
        lmmDGE <- LMMDGEDream$new()
      }
      private$lmmDrugRepurposeCore <- LMMDrugRepurposeCore$new(lmmDGE, drugSignatureLoader)
    },
    compute = function(rna_seq_data, rna_seq_metadata,
                       formula, disease_name, disease_n_most_significant_genes,
                       drugs, drugs_genes, random_distribution_size = 10^5,
                       drug_perturbation_time = NA, parallel_computation = F,
                       filter_by_protein_coding = F
    ) {
      return(
        private$lmmDrugRepurposeCore$compute(
          rna_seq_data, rna_seq_metadata,
          formula, disease_name, disease_n_most_significant_genes,
          drugs, drugs_genes, random_distribution_size,
          drug_perturbation_time, parallel_computation,
          filter_by_protein_coding
        )
      )
    }
  ),
  private = list(
    lmmDrugRepurposeCore = NA
  )
)
