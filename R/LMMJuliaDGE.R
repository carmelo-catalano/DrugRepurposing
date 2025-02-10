LMMJuliaDGE <- R6Class(
  "LMMJuliaDGE",
  public = list(
    initialize = function() {
      private$geneFilterByProteinCoding <- GeneFilterByProteinCoding$new()
      private$juliaLMMToDataFrameMapper <- JuliaLMMToDataFrameMapper$new()
      private$juliaSetuper <- JuliaSetuper$new()
    },
    compute = function(rna_seq_data, rna_seq_metadata, formula, filter_by_protein_coding = F) {
      private$juliaSetuper$setup()
      data_size <- dim(rna_seq_data)
      dgrpLogger$log(sprintf("start LMM Julia differential gene expression computation, data size: %s X %s", data_size[1], data_size[2]))
      if (filter_by_protein_coding) {
        rna_seq_data <- private$geneFilterByProteinCoding$filterById(rna_seq_data)
        data_size <- dim(rna_seq_data)
        dgrpLogger$log(sprintf("RNA seq data size after filtering by protein coding genes: %s X %s", data_size[1], data_size[2]))
      }
      startTime <- Sys.time()
      furmula_items <- as.character(formula)
      differential_expression <- data.frame()
      data <- rna_seq_metadata
      for (i in 1:data_size[1]) {
        data[[furmula_items[2]]] <- as.numeric(rna_seq_data[i,])
        dge <- julia_call("fit", julia_eval("LinearMixedModel"), formula, data, REML = T)
        differential_expression <- rbind(differential_expression, private$juliaLMMToDataFrameMapper$map(dge, rownames(rna_seq_data[i,])))
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
    juliaLMMToDataFrameMapper = NA
  )
)
