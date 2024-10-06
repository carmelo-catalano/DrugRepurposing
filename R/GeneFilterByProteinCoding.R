library(R6)
# source("modules/config.R")

GeneFilterByProteinCoding <- R6Class(
  "GeneFilterByProteinCoding",
  public = list(
    filter = function(gene_expressions) {
      protein_coding_genes_file <- absolute_package_filename(config$protein_coding_genes_filename)
      protein_coding_genes <- readRDS(protein_coding_genes_file)
      gene_expressions$gene <- rownames(gene_expressions)
      gene_expressions <- subset(gene_expressions, gene %in% protein_coding_genes)
      gene_expressions$gene <- NULL
      return(gene_expressions)
    }
  )
)

