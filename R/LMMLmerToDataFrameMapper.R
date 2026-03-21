LMMLmerToDataFrameMapper <- R6Class(
  "LMMLmerToDataFrameMapper",
  inherit = LMMToDataFrameMapperAbstract,
  public = list(
    map = function(LMM_output, gene_id = NA, sample_name_column_name = NA, sample_name_column_name_mapped = "sample_name") {
      # estrae i coefficienti dell'analisi "lmer". Esempio:
      #                               Estimate      Std. Error  t value
      # (Intercept)                   5.459338302   0.27436280  19.89824544
      # pert_inametyrphostin-AG-1296  -0.032810809  0.12512476  -0.26222474
      # pert_inametyrphostin-AG-1478  0.115920192   0.12512476  0.92643686
      differential_expression <- as.data.frame(coef(summary(LMM_output)))
      # elimina la prima riga contenente l'intercetta
      differential_expression <- differential_expression[2:nrow(differential_expression),]

      old_column_names <- c("Estimate", "Std. Error", "t value")
      new_column_names <- c("DE_log2_FC", "std.error", "t.value")
      if (!obj_is_na(gene_id)) {
        differential_expression$gene_id <- gene_id
        old_column_names <- c("gene_id", old_column_names)
        new_column_names <- c("gene_id", new_column_names)
      }
      if (!obj_is_na(sample_name_column_name)) {
        # crea la colonna drug dai nomi delle righe dei coefficienti dell'analisi "lmer"
        differential_expression[[sample_name_column_name_mapped]] <- rownames(differential_expression)
        # elimina il prefisso pert_iname dal nome del farmaco nella colonna drug
        differential_expression[[sample_name_column_name_mapped]] <- substr(differential_expression[[sample_name_column_name_mapped]], nchar(sample_name_column_name) + 1, nchar(differential_expression[[sample_name_column_name_mapped]]))
        old_column_names <- c(sample_name_column_name_mapped, old_column_names)
        new_column_names <- c(sample_name_column_name_mapped, new_column_names)
      }

      # lascia solo le colonne contenenti i dati necessari
      differential_expression <- differential_expression[, old_column_names]
      # rinomina le colonne
      colnames(differential_expression) <- new_column_names
      # elimina i nomi delle righe
      rownames(differential_expression) <- NULL
      # risultato finale:
      # drug                gene  Estimate      Std. Error  t value
      # tyrphostin-AG-1296  PAX8  -0.032810809  0.12512476  -0.26222474
      # tyrphostin-AG-1478  PAX8  0.115920192   0.12512476  0.92643686
      return(differential_expression)
    }
  )
)
