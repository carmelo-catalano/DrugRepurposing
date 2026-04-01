LINCSLMMLmerToDataFrameMapper <- R6Class(
  "LINCSLMMLmerToDataFrameMapper",
  inherit = LINCSLMMToDataFrameMapperAbstract,
  public = list(
    initialize = function() {
      private$lmmLmerToDataFrameMapper <- LMMLmerToDataFrameMapper$new()
    },
    map = function(LMM_output, gene_id = NA, lmm_fixed_effect_column_name = NA, lmm_fixed_effect_new_column_name = NA, LINCS_drug_rename_column_name = "pert_iname") {
      dge <- private$lmmLmerToDataFrameMapper$map(LMM_output, gene_id, lmm_fixed_effect_column_name, lmm_fixed_effect_new_column_name)
      if (!obj_is_na(lmm_fixed_effect_column_name) && !obj_is_na(LINCS_drug_rename_column_name)) {
        if (obj_is_na(lmm_fixed_effect_new_column_name)) {
          lmm_fixed_effect_new_column_name <- lmm_fixed_effect_column_name
        }
        dge[[lmm_fixed_effect_new_column_name]] <- substr(dge[[lmm_fixed_effect_new_column_name]], nchar(LINCS_drug_rename_column_name) + 1, nchar(dge[[lmm_fixed_effect_new_column_name]]))
      }
      return(dge)
    }
  ),
  private = list(
    lmmLmerToDataFrameMapper = NA
  )
)
