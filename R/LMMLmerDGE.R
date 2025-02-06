LMMLmerDGE <- R6Class(
  "LMMLmerDGE",
  public = list(
    initialize = function() {
      private$geneFilterByProteinCoding <- GeneFilterByProteinCoding$new()
      private$lmerLMMToDataFrameMapper <- LmerLMMToDataFrameMapper$new()
    },
    compute = function(rna_seq_data, rna_seq_metadata, formula, filter_by_protein_coding = F) {
      data_size <- dim(rna_seq_data)
      dgrpLogger$log(sprintf("start LMM Voom differential gene expression computation, data size: %s X %s", data_size[1], data_size[2]))
      if (filter_by_protein_coding) {
        rna_seq_data <- private$geneFilterByProteinCoding$filterById(rna_seq_data)
        data_size <- dim(rna_seq_data)
        dgrpLogger$log(sprintf("RNA seq data size after filtering by protein coding genes: %s X %s", data_size[1], data_size[2]))
      }
      startTime <- Sys.time()
      differential_expression <- data.frame()
      data <- rna_seq_metadata
      for (i in 1:data_size[1]) {
        data$sample <- as.numeric(rna_seq_data[i,])
        differential_expression <- rbind(differential_expression, private$lmerLMMToDataFrameMapper$map(lmer(formula, data = data, control = lmerControl(calc.derivs = FALSE)), rownames(rna_seq_data[i,])))
      }
      totalTime <- Sys.time() - startTime
      colnames(differential_expression) <- c("gene_id", "DE_log2_FC", "std.error", "t.value")
      differential_expression <- differential_expression[order(differential_expression$gene_id),]
      dgrpLogger$log(sprintf("end LMM Voom differential gene expression computation, time: %s %s", totalTime, attr(totalTime, "units")))
      return(differential_expression)
    }
  ),
  private = list(
    geneFilterByProteinCoding = NA,
    lmerLMMToDataFrameMapper = NA
  )
)
