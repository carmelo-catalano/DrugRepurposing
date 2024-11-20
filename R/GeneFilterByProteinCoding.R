library(R6)
# source("modules/config.R")

GeneFilterByProteinCoding <- R6Class(
  "GeneFilterByProteinCoding",
  public = list(
    filter = function(gene_expressions) {
      protein_coding_genes <- package_readRDS(config$protein_coding_genes_filename)
      gene_expressions <- cbind(gene_expressions, as.integer(rownames(gene_expressions)))
      colnames(gene_expressions)[ncol(gene_expressions)] <- "gene_id"
      gene_expressions <- gene_expressions[gene_expressions[, "gene_id"] %in% protein_coding_genes$gene_id,]
      gene_expressions <- gene_expressions[, colnames(gene_expressions) != 'gene_id']
      return(gene_expressions)
    }
  )
)

