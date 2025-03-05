
BinChenDiseaseDGEDrugConnectivityScore <- R6Class(
  "BinChenDiseaseDGEDrugConnectivityScore",
  public = list(
    initialize = function(parallel_computation = F) {
      private$diseaseSignatureEstimateMapper <- DiseaseSignatureEstimateMapper$new()
      private$binChenCMapScoreByDrugDGE <- BinChenCMapScoreByDrugDGE$new()
      private$downregulatedGeneFilter <- DownregulatedGeneFilter$new()
      private$upregulatedGeneFilter <- UpregulatedGeneFilter$new()
      private$drugSignatureMapper <- DrugSignatureMapper$new()
      if (parallel_computation) {
        private$randomConnectivityScoreDistribution <- RandomConnectivityScoreDistributionParallel$new()
      }else {
        private$randomConnectivityScoreDistribution <- RandomConnectivityScoreDistributionSync$new()
      }
      private$connectivityScorePValue <- ConnectivityScorePValue$new()
    },
    compute = function(disease_dge, drug_dge, disease_n_most_significant_genes, drug_dge_t_value_column_name = "t.value", random_distribution_size = 10^5, compute_p_value = T) {
      disease_dge <- subset(disease_dge, disease_dge$gene_id %in% drug_dge$gene_id)
      drug_signature <- subset(drug_dge, drug_dge$gene_id %in% disease_dge$gene_id)
      drug_signature <- private$drugSignatureMapper$map(drug_signature, drug_dge_t_value_column_name)
      disease_dge$abs_t.value <- abs(disease_dge$t.value)
      disease_dge <- disease_dge[order(disease_dge$abs_t.value, decreasing = T),]
      disease_signature <- disease_dge[1:disease_n_most_significant_genes, , drop = FALSE]
      disease_signature <- private$diseaseSignatureEstimateMapper$map(disease_signature)
      disease_signature_down_regulated_genes <- private$downregulatedGeneFilter$filter(disease_signature)
      disease_signature_up_regulated_genes <- private$upregulatedGeneFilter$filter(disease_signature)
      connectivity_score <- private$
        binChenCMapScoreByDrugDGE$
        compute(disease_signature_down_regulated_genes, disease_signature_up_regulated_genes, drug_signature)
      if (compute_p_value) {
        random_connectivity_score_distribution <-
          private$
            randomConnectivityScoreDistribution$
            compute(
            n_disease_signature_down_regulated_genes = dim(disease_signature_down_regulated_genes)[1],
            n_disease_signature_up_regulated_genes = dim(disease_signature_up_regulated_genes)[1],
            n_drug_signatures_genes = dim(drug_signature)[1],
            random_distribution_size = random_distribution_size # 10^5
          )
        p.value <- private$connectivityScorePValue$compute(connectivity_score, random_connectivity_score_distribution)
        connectivity_score <- c(connectivity_score, p.value)
      }
      return(connectivity_score)
    }
  ),
  private = list(
    diseaseSignatureEstimateMapper = NA,
    downregulatedGeneFilter = NA,
    upregulatedGeneFilter = NA,
    drugSignatureMapper = NA,
    binChenCMapScoreByDrugDGE = NA,
    randomConnectivityScoreDistribution = NA,
    connectivityScorePValue = NA
  )
)
