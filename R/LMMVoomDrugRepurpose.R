LMMVoomDrugRepurpose <- R6Class(
  "LMMVoomDrugRepurpose",
  public = list(
    initialize = function(lmmVoomDGE = NA, drugSignatureLoader = NA) {
      if (!obj_is_na(lmmVoomDGE)) {
        if (!"LMMVoomDGEAbstract" %in% class(lmmVoomDGE))
          stop("incompatible parameter type: the class type of lmmVoomDGE must be a subclass of LMMVoomDGEAbstract")
        lmmVoomDGE <- lmmVoomDGE
      }else {
        lmmVoomDGE <- LMMVoomDGEDream$new()
      }
      private$lmmVoomDrugRepurposeCore <- LMMDrugRepurposeCore$new(lmmVoomDGE, drugSignatureLoader)
    },
    compute = function(rna_seq_data, rna_seq_metadata,
                       formula, disease_name, disease_n_most_significant_genes,
                       drugs, drugs_genes, random_distribution_size = 10^5,
                       drug_perturbation_time = NA, parallel_computation = F,
                       filter_by_protein_coding = F
    ) {
      return(
        private$lmmVoomDrugRepurposeCore$compute(
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
    lmmVoomDrugRepurposeCore = NA
  )
)
