DichotomicDGE <- R6Class(
  "DichotomicDGE",
  inherit = DichotomicDGEAbstract,
  public = list(
    initialize = function(geneFilter = NA) {
      if (!obj_is_na(geneFilter)) {
        if (!"GeneFilterAbstract" %in% class(geneFilter))
          stop("incompatible parameter type: the class type of geneFilter must be a subclass of GeneFilterAbstract")
        private$geneFilter <- geneFilter
      }else {
        private$geneFilter <- MeanThresholdGeneFilter$new()
      }
      private$dichotomicRNADataMapper <- DichotomicRNADataMapper$new()
      private$dgeMapper <- DGEMapper$new()
      private$geneFilterByProteinCoding <- GeneFilterByProteinCoding$new()
    },
    compute = function(rna_data, sample_01_map, test_sample_name, filter_by_protein_coding = FALSE) {
      gene_experiments_data <- private$dichotomicRNADataMapper$map(rna_data, sample_01_map, test_sample_name)
      gene_experiments_data$gene_expressions <- private$geneFilter$filter(gene_experiments_data$gene_expressions, gene_experiments_data$sample_types)
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
    geneFilter = NA,
    dichotomicRNADataMapper = NA,
    geneFilterByProteinCoding = NA,
    dgeMapper = NA
  )
)
