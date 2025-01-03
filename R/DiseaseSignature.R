library(R6)
library(edgeR)
# source("modules/disease_signature/GeneFilterByProteinCoding.R")
# source("modules/disease_signature/DiseaseDifferentialExpression.R")

DiseaseSignature <- R6Class(
  "DiseaseSignature",
  public = list(
    initialize = function(differentialExpression = NA) {
      if (!obj_is_na(differentialExpression)) {
        if (!"DiseaseDifferentialExpressionAbstract" %in% class(differentialExpression))
          stop("the differentialExpression instance must by of type DiseaseDifferentialExpressionAbstract")
        private$differentialExpression <- differentialExpression
      }else {
        private$differentialExpression <- DichotomicVoomDifferentialExpression$new()
      }
      private$diseaseSignatureMapper <- DiseaseSignatureMapper$new()
    },
    compute = function(gene_experiments_data) {
      differential_expression <- private$differentialExpression$compute(gene_experiments_data)
      differential_expression$std.error <- differential_expression$logFC / differential_expression$t
      differential_expression <- private$diseaseSignatureMapper$map(differential_expression)
      return(differential_expression)
    }
  ),
  private = list(
    differentialExpression = NA,
    diseaseSignatureMapper = NA
  )
)