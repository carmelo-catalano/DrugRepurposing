library(R6)

GeneFilterByProteinCoding <- R6Class(
  "GeneFilterByProteinCoding",
  public = list(
    initialize = function() {
      private$protein_coding_gene <- package_readRDS(config$protein_coding_gene_filename)
    },
    filterById = function(gene_expressions) {
      return(gene_expressions[rownames(gene_expressions) %in% private$protein_coding_gene$id,])
    },
    filterBySymbol = function(gene_expressions) {
      return(gene_expressions[rownames(gene_expressions) %in% private$protein_coding_gene$symbol,])
    },
    filterByEnsemblId = function(gene_expressions) {
      return(gene_expressions[rownames(gene_expressions) %in% private$protein_coding_gene$ensemblId,])
    }
  ),
  private = list(
    protein_coding_gene = NA
  )
)

