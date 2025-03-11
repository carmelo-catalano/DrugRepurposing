LMMToDataFrameMapperAbstract <- R6Class(
  "LMMToDataFrameMapperAbstract",
  public = list(
    map = function(LMM_output, gene_symbol = NA, sample_type_field_name, sample_type_field_name_mapped) {
      stop("I'm an abstract method, implement me")
    }
  )
)