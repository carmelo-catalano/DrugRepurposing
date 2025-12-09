DichotomicVoomDGE <- R6Class(
  "DichotomicVoomDGE",
  inherit = DichotomicDGEAbstract,
  public = list(
    initialize = function(geneFilter = NA) {
      if (!obj_is_na(geneFilter)) {
        if (!"GeneFilterAbstract" %in% class(geneFilter))
          stop("incompatible parameter type: the class type of geneFilter must be a subclass of GeneFilterAbstract")
        private$geneFilter <- geneFilter
      }else {
        private$geneFilter <- LowCountsGeneFilter$new()
      }
      private$dichotomicRNADataMapper <- DichotomicRNADataMapper$new()
      private$dgeMapper <- DGEMapper$new()
      private$geneFilterByProteinCoding <- GeneFilterByProteinCoding$new()
    },
    compute = function(rna_seq, sample_01_map, filter_by_protein_coding = FALSE) {
      gene_experiments_data <- private$dichotomicRNADataMapper$map(rna_seq, sample_01_map)
      gene_experiments_data$gene_expressions <- private$geneFilter$filter(gene_experiments_data$gene_expressions, gene_experiments_data$sample_types)
      if (filter_by_protein_coding) {
        gene_experiments_data$gene_expressions <- private$geneFilterByProteinCoding$filterById(gene_experiments_data$gene_expressions)
      }
      samples_metadata <- data.frame(
        sample_types = gene_experiments_data$sample_types,
        sample = colnames(gene_experiments_data$gene_expressions)
      )
      dge <- DGEList(gene_experiments_data$gene_expressions, remove.zeros = TRUE)
      dge <- calcNormFactors(dge, method = 'upperquartile')
      design <- model.matrix(~sample_types, data = samples_metadata)
      voom_data <- voom(dge, design, plot = FALSE)
      fit_voom <- lmFit(voom_data, design)
      eBayes_fit_voom <- eBayes(fit_voom)
      differential_expression <- topTable(eBayes_fit_voom, coef = 2, number = 10^6)
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
