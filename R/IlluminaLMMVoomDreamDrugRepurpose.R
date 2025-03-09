IlluminaLMMVoomDreamDrugRepurpose <- R6Class(
  "IlluminaLMMVoomDreamDrugRepurpose",
  public = list(
    compute = function(rna_seq_metadata_filename,rna_seq_data_filename,
                       formula, tissue_status_field_name,
                       tissue_statuses_to_be_tested, tissue_statuses_map,
                       accession_field_name = "accession", additional_fields = FA,
                       disease_name, disease_n_most_significant_genes, drug_dge_dir,
                       drugs, drugs_genes, drug_gde_t_value_column_name = "t.value",
                       random_distribution_size = 10^5,
                       drug_perturbation_time = NA, parallel_computation = F,
                       filter_by_protein_coding = F
    ) {
      illuminaLMMVoomDGE <- IlluminaLMMVoomDreamDGE$new()
      drugSignatureLoaderByDrugName <- DrugSignatureLoaderByDrugName$new(drug_dge_dir, drug_gde_t_value_column_name)
      binChenDiseaseDGEDrugListConnectivityScore <- BinChenDiseaseDGEDrugListConnectivityScore$new(drugSignatureLoaderByDrugName)
      startTime <- Sys.time()
      dgrpLogger$log("start drug repurposing computation")
      disease_dge <- illuminaLMMVoomDGE$compute(
        rna_seq_metadata_filename,
        rna_seq_data_filename,
        formula,
        tissue_status_field_name,
        tissue_statuses_to_be_tested,
        tissue_statuses_map,
        accession_field_name,
        additional_fields,
        filter_by_protein_coding)
      connectivity_score <- binChenDiseaseDGEDrugListConnectivityScore$compute(
        disease_dge, drugs, drugs_genes, disease_n_most_significant_genes, random_distribution_size, disease_name, drug_perturbation_time, parallel_computation)
      totalTime <- Sys.time() - startTime
      dgrpLogger$log(sprintf("end drug repurposing computation, time: %s %s", totalTime, attr(totalTime, "units")))
      return(connectivity_score)
    }
  )
)
