LMMDGEJulia <- R6Class(
  "LMMDGEJulia",
  inherit = LMMDGEAbstract,
  public = list(
    initialize = function() {
      private$geneFilterByProteinCoding <- GeneFilterByProteinCoding$new()
      private$lmmJuliaToDataFrameMapper <- LMMJuliaToDataFrameMapper$new()
      private$juliaSetuper <- JuliaSetuper$new()
    },
    compute = function(rna_data, rna_metadata, formula, filter_by_protein_coding = F) {
      private$juliaSetuper$setup()
      data_size <- dim(rna_data)
      dgrpLogger$log(sprintf("start LMM Julia differential gene expression computation, data size: %s X %s", data_size[1], data_size[2]))
      if (filter_by_protein_coding) {
        rna_data <- private$geneFilterByProteinCoding$filterById(rna_data)
        data_size <- dim(rna_data)
        dgrpLogger$log(sprintf("RNA seq data size after filtering by protein coding genes: %s X %s", data_size[1], data_size[2]))
      }
      startTime <- Sys.time()
      differential_expression <- data.frame()
      data <- rna_metadata
      dependet_variable_name <- "dependet_variable_random_name_a1b"
      julia_formula <- set_dependent_variable(formula, dependet_variable_name)
      for (i in 1:data_size[1]) {
        data[[dependet_variable_name]] <- as.numeric(rna_data[i,])
        dge <- julia_call("fit", julia_eval("LinearMixedModel"), julia_formula, data, REML = T)
        differential_expression <- rbind(differential_expression, private$lmmJuliaToDataFrameMapper$map(dge, rownames(rna_data)[i]))
      }
      totalTime <- Sys.time() - startTime
      differential_expression <- differential_expression[order(differential_expression$gene_id),]
      differential_expression$adj.p.value <- p.adjust(differential_expression$p.value, method = "BH")
      dgrpLogger$log(sprintf("end LMM Julia differential gene expression computation, time: %s %s", totalTime, attr(totalTime, "units")))
      return(differential_expression)
    }
  ),
  private = list(
    juliaSetuper = NA,
    geneFilterByProteinCoding = NA,
    lmmJuliaToDataFrameMapper = NA
  )
)
