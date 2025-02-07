JuliaLMMToDataFrameMapper <- R6Class(
  "JuliaLMMToDataFrameMapper",
  inherit = LMMToDataFrameMapperAbstract,
  public = list(
    map = function(LMM_output, gene_id) {
      LMM_table <- julia_call("coeftable", LMM_output)
      LMM_table <- JuliaCall::field(LMM_table, "cols")
      DE_log2_FC <- LMM_table[[1]][-1]
      std.error <- LMM_table[[2]][-1]
      t.value <- DE_log2_FC / std.error
      p.value <- LMM_table[[4]][-1]
      dge <- data.frame(
        gene_id = gene_id,
        DE_log2_FC = DE_log2_FC,
        std.error = std.error,
        t.value = t.value,
        p.value = p.value
      )
      return(dge)
    }
  )
)
