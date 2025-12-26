DichotomicVoomDrugRepurpose <- R6Class(
  "DichotomicVoomDrugRepurpose",
  public = list(
    initialize = function(geneFilter = NA, drugSignatureLoader = NA, dgeToSignatureMapper = NA) {
      private$dichotomicDrugRepurposeCore <- DichotomicDrugRepurposeCore$new(DichotomicVoomDGE$new(geneFilter), drugSignatureLoader, dgeToSignatureMapper)
    },
    compute = function(rna_seq, sample_01_map, drugs, drugs_genes, random_distribution_size = 10^5,
                       disease_name = NA, drug_perturbation_time = NA, filter_by_protein_coding = FALSE,
                       parallel_computation = FALSE, signature_mapper_parameter = NA
    ) {
      return(
        private$dichotomicDrugRepurposeCore$compute(
          rna_seq, sample_01_map, drugs, drugs_genes, random_distribution_size, disease_name,
          drug_perturbation_time, filter_by_protein_coding, parallel_computation,
          signature_mapper_parameter
        )
      )
    }
  ),
  private = list(
    dichotomicDrugRepurposeCore = NA
  )
)