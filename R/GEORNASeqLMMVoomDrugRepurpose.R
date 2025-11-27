GEORNASeqLMMVoomDrugRepurpose <- R6Class(
  "GEORNASeqLMMVoomDrugRepurpose",
  public = list(
    initialize = function(geoRNASeqLMMVoomDGE = NA, dgeToSignatureMapper = NA) {
      if (!obj_is_na(geoRNASeqLMMVoomDGE)) {
        if (!"GEORNASeqLMMVoomDGEAbstract" %in% class(geoRNASeqLMMVoomDGE))
          stop("incompatible parameter type: the class type of geoRNASeqLMMVoomDGE must be a subclass of GEORNASeqLMMVoomDGEAbstract")
        private$geoRNASeqLMMVoomDGE <- geoRNASeqLMMVoomDGE
      }else {
        private$geoRNASeqLMMVoomDGE <- GEORNASeqLMMVoomDGEDream$new()
      }
      private$dgeToSignatureMapper <- dgeToSignatureMapper
    },
    compute = function(rna_seq_data_filename, rna_seq_metadata_filename, formula,
                       tissue_status_field_name, tissue_statuses_to_be_tested,
                       tissue_statuses_map, sample_id_field_name = "accession",
                       additional_fields = NA, drug_dge_dir, drugs,
                       drugs_genes, drug_gde_t_value_column_name = "t.value",
                       random_distribution_size = 10^5, disease_name = NA, drug_perturbation_time = NA,
                       parallel_computation = FALSE, filter_by_protein_coding = FALSE,
                       signature_mapper_parameter = NA
    ) {
      drugSignatureLoaderByDrugName <- DrugSignatureLoaderByDrugName$new(drug_dge_dir, drug_gde_t_value_column_name)
      binChenDiseaseDGEDrugListConnectivityScore <- BinChenDiseaseDGEDrugListConnectivityScore$new(drugSignatureLoaderByDrugName, private$dgeToSignatureMapper)
      startTime <- Sys.time()
      dgrpLogger$log("start drug repurposing computation")
      disease_dge <- private$geoRNASeqLMMVoomDGE$compute(
        rna_seq_data_filename,
        rna_seq_metadata_filename,
        formula,
        tissue_status_field_name,
        tissue_statuses_to_be_tested,
        tissue_statuses_map,
        sample_id_field_name,
        additional_fields,
        filter_by_protein_coding)
      connectivity_score <- binChenDiseaseDGEDrugListConnectivityScore$compute(
        disease_dge, drugs, drugs_genes, random_distribution_size, disease_name,
        drug_perturbation_time, parallel_computation, signature_mapper_parameter
      )
      totalTime <- Sys.time() - startTime
      dgrpLogger$log(sprintf("end drug repurposing computation, time: %s %s", totalTime, attr(totalTime, "units")))
      return(connectivity_score)
    }
  ), private = list(
    geoRNASeqLMMVoomDGE = NA,
    dgeToSignatureMapper = NA
  )
)
