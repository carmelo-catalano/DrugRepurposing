library(R6)
AddGeneSymbolColumn <- R6Class(
  "AddGeneSymbolColumn",
  public = list(
    add = function(gene_expressions, id_gene_association) {
      colnames(gene_expressions)[colnames(gene_expressions) == "gene"]<-"ID"
      gene_expressions <- merge(x = id_gene_association, y = gene_expressions, by.x = "ID", by.y = "ID")
      colnames(gene_expressions)[colnames(gene_expressions) == "ID"]<-"gene_id"
      colnames(gene_expressions)[colnames(gene_expressions) == "gene"]<-"gene_symbol"
      return(gene_expressions)
    }
  )
)