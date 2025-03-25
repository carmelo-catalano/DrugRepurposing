DichotomicVoomDrugRepurpose <- R6Class(
  "DichotomicVoomDrugRepurpose",
  public = list(
    initialize = function(geneFilter = NA) {
      private$dichotomicDrugRepurposeCore <- DichotomicDrugRepurposeCore$new(DichotomicVoomDGE$new(geneFilter))
    },
    compute = function(rna_seq, sample_01_map, disease_name,
                       disease_n_most_significant_genes, drug_dge_dir,
                       drugs, drugs_genes, drug_dge_t_value_column_name = "t.value",
                       random_distribution_size = 10^5,
                       drug_perturbation_time = NA, filter_by_protein_coding = F,
                       parallel_computation = F
    ) {
      return(
        private$dichotomicDrugRepurposeCore$compute(
          rna_seq, sample_01_map, disease_name,
          disease_n_most_significant_genes, drug_dge_dir,
          drugs, drugs_genes, drug_dge_t_value_column_name,
          random_distribution_size,
          drug_perturbation_time, filter_by_protein_coding,
          parallel_computation
        )
      )
    }
  ),
  private = list(
    dichotomicDrugRepurposeCore = NA
  )
)