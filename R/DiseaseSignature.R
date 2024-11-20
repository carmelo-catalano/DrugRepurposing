library(R6)
library(edgeR)
# source("modules/disease_signature/GeneFilterByProteinCoding.R")
# source("modules/disease_signature/DiseaseDifferentialExpression.R")

DiseaseSignature <- R6Class(
  "DiseaseSignature",
  public = list(
    initialize = function(differentialExpression = NA) {
      private$geneFilterByProteinCoding <- GeneFilterByProteinCoding$new()
      if (!obj_is_na(differentialExpression)) {
        if (!"DiseaseDifferentialExpressionAbstract" %in% class(differentialExpression))
          stop("the differentialExpression instance must by of type DiseaseDifferentialExpressionAbstract")
        private$differentialExpression <- differentialExpression
      }else {
        private$differentialExpression <- DichotomicVoomDifferentialExpression$new()
      }
      private$geneExpressionFormatter <- GeneExpressionFormatter$new()
    },
    compute = function(gene_experiments_data, filter_by_proteing_coding = T) {
      if (filter_by_proteing_coding) {
        gene_experiments_data$gene_expressions <- private$geneFilterByProteinCoding$filter(gene_experiments_data$gene_expressions)
      }
      dirrerential_expression <- private$differentialExpression$compute(gene_experiments_data)
      toptable_result <- topTable(dirrerential_expression, coef = 2, number = 10^6)
      colnames(toptable_result)[1] <- "DE_log2_FC"
      toptable_result$gene <- rownames(toptable_result)
      toptable_result$DE_log2_FC_SE <- toptable_result$DE_log2_FC / toptable_result$t
      toptable_result <- private$geneExpressionFormatter$format(toptable_result)
      return(toptable_result)
    }
  ),
  private = list(
    geneFilterByProteinCoding = NA,
    differentialExpression = NA,
    geneExpressionFormatter = NA
  )
)