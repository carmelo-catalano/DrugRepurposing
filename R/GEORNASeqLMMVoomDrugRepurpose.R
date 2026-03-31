GEORNASeqLMMVoomDrugRepurpose <- R6Class(
  "GEORNASeqLMMVoomDrugRepurpose",
  public = list(
    initialize = function(geoRNASeqLMMVoomDGE = NA, dgeToSignatureMapper = NA, drugSignatureLoader = NA) {
      if (!obj_is_na(geoRNASeqLMMVoomDGE)) {
        if (!"GEORNASeqLMMVoomDGEAbstract" %in% class(geoRNASeqLMMVoomDGE))
          stop("incompatible parameter type: the class type of geoRNASeqLMMVoomDGE must be a subclass of GEORNASeqLMMVoomDGEAbstract")
        private$geoRNASeqLMMVoomDGE <- geoRNASeqLMMVoomDGE
      }else {
        private$geoRNASeqLMMVoomDGE <- GEORNASeqLMMVoomDGEDream$new()
      }
      private$dgeToSignatureMapper <- dgeToSignatureMapper
      private$drugSignatureLoader <- drugSignatureLoader
    },
    compute = function(rna_seq_data_filename, rna_seq_metadata, formula, drug_signatures, drugs_genes,
                       random_distribution_size = 10^5, random_effect_column_names,
                       sample_status_column_name = "sample_status", disease_name = NA, drug_perturbation_time = NA,
                       parallel_computation = FALSE, filter_by_protein_coding = FALSE,
                       signature_mapper_parameter = NA
    ) {
      binChenDiseaseDGEDrugListConnectivityScore <- BinChenDiseaseDGEDrugListConnectivityScore$new(private$drugSignatureLoader, private$dgeToSignatureMapper)
      startTime <- Sys.time()
      dgrpLogger$log("start drug repurposing computation")
      disease_dge <- private$geoRNASeqLMMVoomDGE$compute(
        rna_seq_data_filename,
        rna_seq_metadata,
        formula,
        random_effect_column_names,
        sample_status_column_name,
        filter_by_protein_coding
      )
      connectivity_score <- binChenDiseaseDGEDrugListConnectivityScore$compute(
        disease_dge, drug_signatures, drugs_genes, random_distribution_size, disease_name,
        drug_perturbation_time, parallel_computation, signature_mapper_parameter
      )
      totalTime <- Sys.time() - startTime
      dgrpLogger$log(sprintf("end drug repurposing computation, time: %s %s", totalTime, attr(totalTime, "units")))
      return(connectivity_score)
    }
  ), private = list(
    geoRNASeqLMMVoomDGE = NA,
    dgeToSignatureMapper = NA,
    drugSignatureLoader = NA
  )
)
