library(R6)
library(edgeR)
# source("modules/disease_signature/GeneFilterByProteinCoding.R")
# source("modules/disease_signature/DiseaseDifferentialExpression.R")

DiseaseSignature <- R6Class(
  "DiseaseSignature",
  public = list(
    initialize = function(diseaseDifferentialExpression = NA) {
      private$geneFilterByProteinCoding <- GeneFilterByProteinCoding$new()
      if (!obj_is_na(diseaseDifferentialExpression)) {
        if (!"DiseaseDifferentialExpressionAbstract" %in% class(diseaseDifferentialExpression))
          stop("the diseaseDifferentialExpression instance must by of type DiseaseDifferentialExpressionAbstract")
        private$diseaseDifferentialExpression <- diseaseDifferentialExpression
      }else {
        private$diseaseDifferentialExpression <- DiseaseDifferentialExpression$new()
      }
    },
    compute = function(gene_experiments_data, filter_by_proteing_coding = T) {
      if (filter_by_proteing_coding) {
        gene_experiments_data$gene_expressions <- private$geneFilterByProteinCoding$filter(gene_experiments_data$gene_expressions)
      }
      dirrerential_expression <- private$diseaseDifferentialExpression$compute(gene_experiments_data)
      toptable_result <- topTable(dirrerential_expression, coef = 2, number = 10^6)
      colnames(toptable_result)[1] <- "DE_log2_FC"
      toptable_result$gene <- rownames(toptable_result)
      toptable_result$DE_log2_FC_SE <- toptable_result$DE_log2_FC / toptable_result$t
      toptable_result <- toptable_result[, c("gene", "DE_log2_FC", "DE_log2_FC_SE", "t", "P.Value", "adj.P.Val")]
      colnames(toptable_result) <- c("gene", "DE_log2_FC", "std.error", "t.value", "p.value", "adj.p.value")
      toptable_result <- toptable_result[order(toptable_result$gene),]
      rownames(toptable_result) <- NULL
      return(toptable_result)
    }
  ),
  private = list(
    geneFilterByProteinCoding = NA,
    diseaseDifferentialExpression = NA
  )
)