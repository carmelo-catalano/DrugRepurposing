LINCSLMMJuliaToDataFrameMapper <- R6Class(
  "LINCSLMMJuliaToDataFrameMapper",
  inherit = LINCSLMMToDataFrameMapperAbstract,
  public = list(
    initialize = function() {
      private$lmmJuliaToDataFrameMapper <- LMMJuliaToDataFrameMapper$new()
    },
    map = function(LMM_output, gene_id = NA, lmm_fixed_effect_column_name = NA, lmm_fixed_effect_new_column_name = NA, LINCS_drug_rename_column_name = NA) {
      dge <- private$lmmJuliaToDataFrameMapper$map(LMM_output, gene_id, lmm_fixed_effect_column_name, lmm_fixed_effect_new_column_name)
      if (!obj_is_na(lmm_fixed_effect_column_name) && !obj_is_na(LINCS_drug_rename_column_name)) {
        if (obj_is_na(lmm_fixed_effect_new_column_name)) {
          lmm_fixed_effect_new_column_name <- lmm_fixed_effect_column_name
        }
        dge[lmm_fixed_effect_new_column_name] <- substr(dge[[lmm_fixed_effect_new_column_name]], nchar(LINCS_drug_rename_column_name) + 3, nchar(dge[[lmm_fixed_effect_new_column_name]]))
      }
      return(dge)
    }
  ),
  private = list(
    lmmJuliaToDataFrameMapper = NA
  )
)
