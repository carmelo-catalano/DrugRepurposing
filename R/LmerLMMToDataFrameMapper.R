LmerLMMToDataFrameMapper <- R6Class(
  "LmerLMMToDataFrameMapper",
  inherit = LMMToDataFrameMapperAbstract,
  public = list(
    map = function(LMM_output, gene_id) {
      # estrae i coefficienti dell'analisi "lmer". Esempio:
      #                               Estimate      Std. Error  t value
      # (Intercept)                   5.459338302   0.27436280  19.89824544
      # pert_inametyrphostin-AG-1296  -0.032810809  0.12512476  -0.26222474
      differential_expression <- as.data.frame(coef(summary(LMM_output)))
      # elimina la prima riga contenente l'intercetta
      differential_expression <- differential_expression[2:nrow(differential_expression),]

      differential_expression$gene_id <- gene_id
      # lascia solo le colonne contenenti i dati necessari
      differential_expression <- differential_expression[, c("gene_id", "Estimate", "Std. Error", "t value")]
      # rinomina le colonne

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