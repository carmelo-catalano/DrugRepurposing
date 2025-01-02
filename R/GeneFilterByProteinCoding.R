library(R6)
# source("modules/config.R")

GeneFilterByProteinCoding <- R6Class(
  "GeneFilterByProteinCoding",
  public = list(
    filter = function(gene_expressions) {
      protein_coding_genes <- package_readRDS(config$protein_coding_genes_filename)
      gene_expressions <- gene_expressions[rownames(gene_expressions) %in% protein_coding_genes$gene_id,]
      return(gene_expressions)
    }
  )
)

