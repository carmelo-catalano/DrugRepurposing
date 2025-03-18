IlluminaLMMVoomDrugRepurpose <- R6Class(
  "IlluminaLMMVoomDrugRepurpose",
  public = list(
    initialize = function(illuminaLMMVoomDGE = NA) {
      if (!obj_is_na(illuminaLMMVoomDGE)) {
        if (!"IlluminaLMMVoomDGEAbstract" %in% class(illuminaLMMVoomDGE))
          stop("incompatible parameter type: the class type of illuminaLMMVoomDGE must be a subclass of IlluminaLMMVoomDGEAbstract")
        private$illuminaLMMVoomDGE <- illuminaLMMVoomDGE
      }else {
        private$illuminaLMMVoomDGE <- IlluminaLMMVoomDGEDream$new()
      }
    },
    compute = function(rna_seq_data_filename, rna_seq_metadata_filename,
                       formula, tissue_status_field_name,
                       tissue_statuses_to_be_tested, tissue_statuses_map,
                       sample_id_field_name = "accession", additional_fields = NA,
                       disease_name, disease_n_most_significant_genes, drug_dge_dir,
                       drugs, drugs_genes, drug_gde_t_value_column_name = "t.value",
                       random_distribution_size = 10^5,
                       drug_perturbation_time = NA, parallel_computation = F,
                       filter_by_protein_coding = F
    ) {
      drugSignatureLoaderByDrugName <- DrugSignatureLoaderByDrugName$new(drug_dge_dir, drug_gde_t_value_column_name)
      binChenDiseaseDGEDrugListConnectivityScore <- BinChenDiseaseDGEDrugListConnectivityScore$new(drugSignatureLoaderByDrugName)
      startTime <- Sys.time()
      dgrpLogger$log("start drug repurposing computation")
      disease_dge <- private$illuminaLMMVoomDGE$compute(
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
        disease_dge, drugs, drugs_genes, disease_n_most_significant_genes, random_distribution_size, disease_name, drug_perturbation_time, parallel_computation)
      totalTime <- Sys.time() - startTime
      dgrpLogger$log(sprintf("end drug repurposing computation, time: %s %s", totalTime, attr(totalTime, "units")))
      return(connectivity_score)
    }
  ), private = list(
    illuminaLMMVoomDGE = NA
  )
)
