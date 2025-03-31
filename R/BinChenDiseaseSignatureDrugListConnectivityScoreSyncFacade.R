BinChenDiseaseSignatureDrugListConnectivityScoreSyncFacade <- R6Class(
  "BinChenDiseaseSignatureDrugListConnectivityScoreSyncFacade",
  public = list(
    initialize = function(drugSignatureLoader = NA) {
      private$binChenDiseaseSignatureDrugListConnectivityScoreCore <- BinChenDiseaseSignatureDrugListConnectivityScoreCore$new(RandomConnectivityScoreDistributionSync$new(), BinChenConnectivityScoreListApplyerSync$new(drugSignatureLoader))
    },
    compute = function(disease_signature, drugs, n_drug_signatures_genes, random_distribution_size = 10^5, disease_name = NA, disease_signature_type = NA, drug_perturbation_time = NA) {
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
               compute(disease_signature, drugs, n_drug_signatures_genes, random_distribution_size, disease_name, disease_signature_type, drug_perturbation_time))
    }
  ),
  private = list(
    binChenDiseaseSignatureDrugListConnectivityScoreCore = NA
  )
)
