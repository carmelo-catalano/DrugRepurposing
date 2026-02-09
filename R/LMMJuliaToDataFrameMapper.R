LMMJuliaToDataFrameMapper <- R6Class(
  "LMMJuliaToDataFrameMapper",
  inherit = LMMToDataFrameMapperAbstract,
  public = list(
    map = function(LMM_output, gene_id = NA, sample_type_field_name = NA, sample_type_field_name_mapped = "sample_type") {
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
      if (!obj_is_na(sample_type_field_name)) {
        sample_statuses <- julia_call("coefnames", LMM_output)[-1]
        sample_statuses <- substr(sample_statuses, nchar(sample_type_field_name) + 3, nchar(sample_statuses))
        dge <- add_column(dge, sample_type = sample_statuses, .before = 1)
        colnames(dge)[1] <- sample_type_field_name_mapped
        dge$adj.p.value <- p.adjust(p.value, method = "BH")
      }
      return(dge)
    }
  )
)
