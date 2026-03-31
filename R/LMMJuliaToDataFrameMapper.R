LMMJuliaToDataFrameMapper <- R6Class(
  "LMMJuliaToDataFrameMapper",
  inherit = LMMToDataFrameMapperAbstract,
  public = list(
    map = function(LMM_output, gene_id = NA, lmm_fixed_effect_column_name = NA, lmm_fixed_effect_new_column_name = NA) {
      LMM_table <- julia_call("coeftable", LMM_output)
      LMM_table <- JuliaCall::field(LMM_table, "cols")
      DE_log2_FC <- LMM_table[[1]][-1]
      std.error <- LMM_table[[2]][-1]
      t.value <- DE_log2_FC / std.error
      p.value <- LMM_table[[4]][-1]
      dge <- data.frame(
        DE_log2_FC = DE_log2_FC,
        std.error = std.error,
        t.value = t.value,
        p.value = p.value
      )
      if (!obj_is_na(gene_id)) {
        dge <- add_column(dge, gene_id = gene_id, .before = 1)
      }
      if (!obj_is_na(lmm_fixed_effect_column_name)) {
        if (obj_is_na(lmm_fixed_effect_new_column_name)) {
          lmm_fixed_effect_new_column_name <- lmm_fixed_effect_column_name
        }
        fixed_effects <- julia_call("coefnames", LMM_output)[-1]
        dge <- add_column(dge, sample_type = fixed_effects, .before = 1)
        colnames(dge)[1] <- lmm_fixed_effect_new_column_name
        dge$adj.p.value <- p.adjust(p.value, method = "BH")
      }
      return(dge)
    }
  )
)
