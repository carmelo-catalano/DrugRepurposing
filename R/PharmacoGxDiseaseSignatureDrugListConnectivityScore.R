PharmacoGxDiseaseSignatureDrugListConnectivityScore <- R6Class(
  "PharmacoGxDiseaseSignatureDrugListConnectivityScore",
  public = list(
    initialize = function(drugSignatureLoader = NA) {
      if (obj_is_na(drugSignatureLoader)) {
        private$drugSignatureLoader <- DrugSignatureLoaderByFilename$new()
      }else {
        private$drugSignatureLoader <- drugSignatureLoader
      }
      private$diseaseDrugListConnectivityScoreMapper <- DiseaseDrugListConnectivityScoreMapper$new()
    },
    compute = function(disease_signature, drug_signatures, n_permutations = 10^4, disease_name = NA, disease_signature_type = NA, drug_perturbation_time = NA) {
      # disease_signature example:
      #         estimate
      # 780     -13,1465
      # 2197    -12,9753
      # 51493   10,4324
      # estimate = t value, row names = gene id

      # Example of drug_signatures where the signature_reference column contains filenames.
      # name         signature_reference
      # ethisterone  drugs/ethisterone.Rds
      # ethoprop     drugs/ethoprop.Rds
      # ethotoin     drugs/ethotoin.Rds

      startTime <- Sys.time()
      dgrpLogger$log(sprintf("start connectivity score computation by PharmacoGx Algorithm"))
      total_drug_signatures <- dim(drug_signatures)[1]
      connectivity_score_matrix <- data.frame()
      rownames(disease_signature) <- disease_signature$gene_id
      disease_signature$gene_id <- NULL
      for (i in 1:total_drug_signatures) {
        drug_signature <- private$drugSignatureLoader$load(drug_signatures$signature_reference[i])
        rownames(drug_signature) <- drug_signature$gene_id
        drug_signature$gene_id <- NULL
        connectivity_score_by_drug <- PharmacoGx::connectivityScore(x = drug_signature, y = disease_signature, method = "fgsea", nperm = n_permutations)
        connectivity_score_matrix <- rbind(connectivity_score_matrix, data.frame(drug_signatures$name[i], connectivity_score_by_drug[1], connectivity_score_by_drug[2]))
      }
      connectivity_scores <- private$
        diseaseDrugListConnectivityScoreMapper$
        map(connectivity_score_matrix, disease_name, disease_signature_type, drug_perturbation_time)
      totalTime <- Sys.time() - startTime
      dgrpLogger$log(sprintf("end connectivity score computation by PharmacoGx Algorithm: time: %s %s", totalTime, attr(totalTime, "units")))
      return(connectivity_scores)
    }
  ),
  private = list(
    drugSignatureLoader = NA,
    diseaseDrugListConnectivityScoreMapper = NA
  )
)
