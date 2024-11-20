library(R6)
# source("modules/disease_signature/Illumina_HiSeq_mapper/IdGeneAssociation.R")
# source("modules/disease_signature/AddGeneColumn.R")

GeneExpressionFormatter <- R6Class(
  "GeneExpressionFormatter",
  public = list(
    initialize = function() {
      private$idGeneAssociation <- IdGeneAssociation$new()
      private$addGeneSymbolColumn <- AddGeneSymbolColumn$new()
    },
    format = function(gene_expressions) {
      gene_expressions <- data.frame(gene_expressions)
      id_gene_association <- private$idGeneAssociation$load()
      gene_expressions <- private$addGeneSymbolColumn$add(gene_expressions, id_gene_association)
      rownames(gene_expressions) <- NULL
      gene_expressions <- gene_expressions[, c("gene_id", "gene_symbol", "DE_log2_FC", "DE_log2_FC_SE", "t", "P.Value", "adj.P.Val")]
      colnames(gene_expressions) <- c("gene_id", "gene_symbol", "DE_log2_FC", "std.error", "t.value", "p.value", "adj.p.value")
      gene_expressions <- gene_expressions[order(gene_expressions$gene_id),]
      return(gene_expressions)
    }
  ),
  private = list(
    idGeneAssociation = NA,
    addGeneSymbolColumn = NA
  )
)