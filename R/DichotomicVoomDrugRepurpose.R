DichotomicVoomDrugRepurpose <- R6Class(
  "DichotomicVoomDrugRepurpose",
  public = list(
    initialize = function(geneFilter = NA, dgeToSignatureMapper = NA) {
      private$dichotomicDrugRepurposeCore <- DichotomicDrugRepurposeCore$new(DichotomicVoomDGE$new(geneFilter), dgeToSignatureMapper)
    },
    compute = function(rna_seq, sample_01_map, drug_dge_dir, drugs, drugs_genes,
                       drug_dge_t_value_column_name = "t.value", random_distribution_size = 10^5,
                       disease_name = NA, drug_perturbation_time = NA, filter_by_protein_coding = FALSE,
                       parallel_computation = FALSE, signature_mapper_parameter = NA
    ) {
      return(
        private$dichotomicDrugRepurposeCore$compute(
          rna_seq, sample_01_map, drug_dge_dir, drugs, drugs_genes, drug_dge_t_value_column_name,
          random_distribution_size, disease_name, drug_perturbation_time, filter_by_protein_coding,
          parallel_computation, signature_mapper_parameter
        )
      )
    }
  ),
  private = list(
    dichotomicDrugRepurposeCore = NA
  )
)