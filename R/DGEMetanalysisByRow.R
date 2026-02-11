DGEMetanalysisByRow <- R6Class(
  "DGEMetanalysisByRow",
  public = list(
    compute = function(dge_A_B) {
      ma_output <- rma(yi = c(dge_A_B$DE_log2_FC_A, dge_A_B$DE_log2_FC_B), sei = c(dge_A_B$std.error_A, dge_A_B$std.error_B))
      dge_A_B[c("DE_log2_FC_A_B", "std.error_A_B", "t.value_A_B", "p.value_A_B")] <-
        c(ma_output$b[, 1], ma_output$se, ma_output$zval, ma_output$pval)
      return(dge_A_B)
    }
  )
)