LMMLmerToDataFrameMapper <- R6Class(
  "LMMLmerToDataFrameMapper",
  inherit = LMMToDataFrameMapperAbstract,
  public = list(
    map = function(LMM_output, gene_id = NA, lmm_fixed_effect_column_name = NA, lmm_fixed_effect_new_column_name = NA) {
      # estrae i coefficienti dell'analisi "lmer". Esempio:
      #                               Estimate      Std. Error  t value
      # (Intercept)                   5.459338302   0.27436280  19.89824544
      # pert_inametyrphostin-AG-1296  -0.032810809  0.12512476  -0.26222474
      # pert_inametyrphostin-AG-1478  0.115920192   0.12512476  0.92643686
      dge <- as.data.frame(coef(summary(LMM_output)))
      # elimina la prima riga contenente l'intercetta
      dge <- dge[2:nrow(dge),]

      old_column_names <- c("Estimate", "Std. Error", "t value")
      new_column_names <- c("DE_log2_FC", "std.error", "t.value")
      if (!obj_is_na(gene_id)) {
        dge$gene_id <- gene_id
        old_column_names <- c("gene_id", old_column_names)
        new_column_names <- c("gene_id", new_column_names)
      }
      if (!obj_is_na(lmm_fixed_effect_column_name)) {
        if (obj_is_na(lmm_fixed_effect_new_column_name)) {
          lmm_fixed_effect_new_column_name <- lmm_fixed_effect_column_name
        }
        # crea la colonna drug dai nomi delle righe dei coefficienti dell'analisi "lmer"
        dge[[lmm_fixed_effect_new_column_name]] <- rownames(dge)
        old_column_names <- c(lmm_fixed_effect_new_column_name, old_column_names)
        new_column_names <- c(lmm_fixed_effect_new_column_name, new_column_names)
      }

      # lascia solo le colonne contenenti i dati necessari
      dge <- dge[, old_column_names]
      # rinomina le colonne
      colnames(dge) <- new_column_names
      # elimina i nomi delle righe
      rownames(dge) <- NULL
      # risultato finale:
      # drug                gene  Estimate      Std. Error  t value
      # tyrphostin-AG-1296  PAX8  -0.032810809  0.12512476  -0.26222474
      # tyrphostin-AG-1478  PAX8  0.115920192   0.12512476  0.92643686
      return(dge)
    }
  )
)
