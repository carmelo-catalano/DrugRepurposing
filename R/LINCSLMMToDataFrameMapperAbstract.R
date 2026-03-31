LINCSLMMToDataFrameMapperAbstract <- R6Class(
  "LINCSLMMToDataFrameMapperAbstract",
  public = list(
    map = function(LMM_output, gene_id, lmm_fixed_effect_column_name, lmm_fixed_effect_new_column_name, LINCS_drug_rename_column_name) {
      stop("I'm an abstract method, please implement me")
    }
  )
)