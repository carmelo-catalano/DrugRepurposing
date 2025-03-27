DiseaseDrugListConnectivityScoreMapper <- R6Class(
  "DiseaseDrugListConnectivityScoreMapper",
  public = list(
    map = function(connectivity_score_matrix, disease = NA, disease_signature_type = NA, drug_perturbation_time = NA) {
      drugs_connectivity_score <- data.frame(
        drug = connectivity_score_matrix[, 1],
        connectivity_score = connectivity_score_matrix[, 2],
        p.value = connectivity_score_matrix[, 3],
        adj.p.value = p.adjust(connectivity_score_matrix[, 3], method = "BH")
      )
      if (!obj_is_na(disease)) {
        drugs_connectivity_score$disease <- disease
      }
      if (!obj_is_na(disease_signature_type)) {
        drugs_connectivity_score$disease_signature_type <- disease_signature_type
      }
      if (!obj_is_na(drug_perturbation_time)) {
        drugs_connectivity_score$drug_perturbation_time <- drug_perturbation_time
      }
      rownames(drugs_connectivity_score) <- NULL
      return(drugs_connectivity_score)
      #     disease   drug      disease_signature_type        perturbation_time   connectivity_score   connectivity_score_p.value
      # 1   als       ABT-737   50 MostSignificantGenes       6h                  0.013243241          0.0034293042000
      # 2   als       ABT-751   50 MostSignificantGenes       6h                  -0.59877771          0.0048975924999
      # 3   als       afatinib  50 MostSignificantGenes       6h                  -0.12349400          0.9004344124111
    }
  )
)
