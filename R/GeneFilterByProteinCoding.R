GeneFilterByProteinCoding <- R6Class(
  "GeneFilterByProteinCoding",
  public = list(
    initialize = function() {
      private$protein_coding_gene <- package_readRDS(config$protein_coding_gene_filename)
      private$protein_coding_gene <- private$protein_coding_gene[private$protein_coding_gene$locusGroup == 'protein-coding gene',]
      private$protein_coding_gene$proteinCoding <- NULL
    },
    filterById = function(gene_expressions) {
      return(gene_expressions[rownames(gene_expressions) %in% private$protein_coding_gene$id,])
    },
    filterByIdOnCondition = function(gene_expressions, filter_by_protein_coding) {
      if (filter_by_protein_coding) {
        gene_expressions <- self$filterById(gene_expressions)
        data_size <- dim(gene_expressions)
        dgrpLogger$log(sprintf("RNA seq data size after filtering by protein coding genes: %s X %s", data_size[1], data_size[2]))
      }
      return(gene_expressions)
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

