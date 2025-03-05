BinChenDiseaseSignatureDrugListConnectivityScoreParallelFacade <- R6Class(
  "BinChenDiseaseSignatureDrugListConnectivityScoreParallelFacade",
  public = list(
    initialize = function(drugSignatureLoader = NA) {
      private$binChenDiseaseSignatureDrugListConnectivityScoreCore <- BinChenDiseaseSignatureDrugListConnectivityScoreCore$new(RandomConnectivityScoreDistributionParallel$new(), BinChenConnectivityScoreListApplyerParallel$new(drugSignatureLoader))
    },
    compute = function(disease_signature, drugs, n_drug_signatures_genes, random_distribution_size = 10^5, disease_name = NA, gene_selection_strategy = NA, drug_perturbation_time = NA) {
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

      return(private$
               binChenDiseaseSignatureDrugListConnectivityScoreCore$
               compute(disease_signature, drugs, n_drug_signatures_genes, random_distribution_size, disease_name, gene_selection_strategy, drug_perturbation_time))
    }
  ),
  private = list(
    binChenDiseaseSignatureDrugListConnectivityScoreCore = NA
  )
)
