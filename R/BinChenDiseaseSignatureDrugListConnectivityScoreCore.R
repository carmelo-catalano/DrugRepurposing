BinChenDiseaseSignatureDrugListConnectivityScoreCore <- R6Class(
  "BinChenDiseaseSignatureDrugListConnectivityScoreCore",
  public = list(
    initialize = function(randomConnectivityScoreDistribution, binChenConnectivityScoreListApplyer) {
      if (!"RandomConnectivityScoreDistributionAbstract" %in% class(randomConnectivityScoreDistribution)) {
        stop("the randomConnectivityScoreDistribution instance must by of type RandomConnectivityScoreDistributionAbstract")
      }
      if (!"BinChenConnectivityScoreListApplyerAbstract" %in% class(binChenConnectivityScoreListApplyer)) {
        stop("the binChenConnectivityScoreListApplyer instance must by of type BinChenConnectivityScoreListApplyerAbstract")
      }
      private$downregulatedGeneFilter <- DownregulatedGeneFilter$new()
      private$upregulatedGeneFilter <- UpregulatedGeneFilter$new()
      private$randomConnectivityScoreDistribution <- randomConnectivityScoreDistribution
      private$binChenConnectivityScoreListApplyer <- binChenConnectivityScoreListApplyer
      private$diseaseDrugListConnectivityScoreMapper <- DiseaseDrugListConnectivityScoreMapper$new()
    },
    compute = function(disease_signature, drugs, n_drug_signatures_genes, n_permutations = 10^5, disease_name = NA, gene_selection_strategy = NA, drug_perturbation_time = NA) {
      # disease_signature example:
      #         estimate
      # 780     -13,1465
      # 2197    -12,9753
      # 51493   10,4324
      # estimate = t value, row names = gene id

      # drugs example:
      # name         filename
      # ethisterone  drugs/ethisterone.Rds
      # ethoprop     drugs/ethoprop.Rds
      # ethotoin     drugs/ethotoin.Rds

      # genera la distribuzione random necessaria per il cacloclo del p-value
      startTime <- Sys.time()
      dgrpLogger$log(sprintf("start connectivity score computation by Bin Chen Algorithm"))
      disease_signature_down_regulated_genes <- private$downregulatedGeneFilter$filter(disease_signature)
      disease_signature_up_regulated_genes <- private$upregulatedGeneFilter$filter(disease_signature)
      random_connectivity_score_distribution <-
        private$randomConnectivityScoreDistribution$compute(
          n_disease_signature_down_regulated_genes = dim(disease_signature_down_regulated_genes)[1],
          n_disease_signature_up_regulated_genes = dim(disease_signature_up_regulated_genes)[1],
          n_drug_signatures_genes = n_drug_signatures_genes,
          n_permutations = n_permutations # 10^5
        )
      connectivity_score_matrix <- private$
        binChenConnectivityScoreListApplyer$
        compute(disease_signature_down_regulated_genes, disease_signature_up_regulated_genes, drugs, random_connectivity_score_distribution)
      connectivity_scores <- private$diseaseDrugListConnectivityScoreMapper$map(connectivity_score_matrix, disease_name, gene_selection_strategy, drug_perturbation_time)
      totalTime <- Sys.time() - startTime
      dgrpLogger$log(sprintf("end connectivity score computation by Bin Chen Algorithm: time: %s %s", totalTime, attr(totalTime, "units")))
      return(connectivity_scores)
    }
  ),
  private = list(
    downregulatedGeneFilter = NA,
    upregulatedGeneFilter = NA,
    randomConnectivityScoreDistribution = NA,
    binChenConnectivityScoreListApplyer = NA,
    diseaseDrugListConnectivityScoreMapper = NA
  )
)
