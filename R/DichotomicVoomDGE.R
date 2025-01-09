library(R6)
library(edgeR)

DichotomicVoomDGE <- R6Class(
  "DichotomicVoomDGE",
  public = list(
    initialize = function() {
      private$voomDGEMapper <- VoomDGEMapper$new()
    },
    compute = function(gene_experiments_data) {
      disease_control_sample_map <- data.frame(
        sample_type = gene_experiments_data$disease_control_groups,
        sample = colnames(gene_experiments_data$gene_expressions)
      )
      dge <- DGEList(gene_experiments_data$gene_expressions, remove.zeros = TRUE)
      dge <- calcNormFactors(dge, method = 'upperquartile')
      design <- model.matrix(~sample_type, data = disease_control_sample_map)
      voom_data <- voom(dge, design, plot = F)
      fit_voom <- lmFit(voom_data, design)
      eBayes_fit_voom <- eBayes(fit_voom)
      differential_expression <- topTable(eBayes_fit_voom, coef = 2, number = 10^6)
      differential_expression$std.error <- differential_expression$logFC / differential_expression$t
      return(private$voomDGEMapper$map(differential_expression))
    }
  ),
  private = list(
    voomDGEMapper = NA
  )
)
