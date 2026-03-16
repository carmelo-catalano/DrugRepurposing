GEORNASeqDichotomicVoomDrugRepurpose <- R6Class(
  "GEORNASeqDichotomicVoomDrugRepurpose",
  public = list(
    initialize = function(dgeToSignatureMapper = NA, drugSignatureLoader = NA) {
      private$dgeToSignatureMapper <- dgeToSignatureMapper
      private$drugSignatureLoader <- drugSignatureLoader
    },
    compute = function(rna_seq_data_filename, sample_01_map, drug_signatures, drugs_genes,
                       random_distribution_size = 10^5, disease_name = NA,
                       drug_perturbation_time = NA, parallel_computation = FALSE,
                       filter_by_protein_coding = FALSE, signature_mapper_parameter = NA
    ) {
      geoRNASeqDichotomicVoomDGE <- GEORNASeqDichotomicVoomDGE$new()
      binChenDiseaseDGEDrugListConnectivityScore <- BinChenDiseaseDGEDrugListConnectivityScore$new(private$drugSignatureLoader, private$dgeToSignatureMapper)
      startTime <- Sys.time()
      dgrpLogger$log("start drug repurposing computation")
      disease_dge <- geoRNASeqDichotomicVoomDGE$compute(rna_seq_data_filename, sample_01_map, filter_by_protein_coding)
      connectivity_score <- binChenDiseaseDGEDrugListConnectivityScore$compute(
        disease_dge, drug_signatures, drugs_genes, random_distribution_size,
        disease_name, drug_perturbation_time, parallel_computation, signature_mapper_parameter
      )
      totalTime <- Sys.time() - startTime
      dgrpLogger$log(sprintf("end drug repurposing computation, time: %s %s", totalTime, attr(totalTime, "units")))
      return(connectivity_score)
    }
  ),
  private = list(
    dgeToSignatureMapper = NA,
    drugSignatureLoader = NA
  )
)