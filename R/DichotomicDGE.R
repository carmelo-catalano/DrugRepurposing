DichotomicDGE <- R6Class(
  "DichotomicDGE",
  public = list(
    initialize = function(geneFilter = NA) {
      private$dicotomicRNASeqMapper <- DicotomicRNASeqMapper$new(geneFilter)
      private$dgeMapper <- DGEMapper$new()
      private$geneFilterByProteinCoding <- GeneFilterByProteinCoding$new()
    },
    compute = function(rna_seq, sample_01_map, test_sample_name, filter_by_protein_coding = F) {
      gene_experiments_data <- private$dicotomicRNASeqMapper$map(rna_seq, sample_01_map, test_sample_name)
      if (filter_by_protein_coding) {
        gene_experiments_data$gene_expressions <- private$geneFilterByProteinCoding$filterById(gene_experiments_data$gene_expressions)
      }
      samples_metadata <- data.frame(
        sample_types = gene_experiments_data$sample_types,
        sample = colnames(gene_experiments_data$gene_expressions)
      )
      design <- model.matrix(~sample_types, data = samples_metadata)
      fit <- lmFit(gene_experiments_data$gene_expressions, design)
      eBayes_fit <- eBayes(fit)
      differential_expression <- topTable(eBayes_fit, coef = 2, number = 10^6)
      differential_expression$std.error <- differential_expression$logFC / differential_expression$t
      return(private$dgeMapper$map(differential_expression))
    }
  ),
  private = list(
    dicotomicRNASeqMapper = NA,
    geneFilterByProteinCoding = NA,
    dgeMapper = NA
  )
)
