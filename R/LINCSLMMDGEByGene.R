LMMDGEByGene <- R6Class(
  "LMMDGEByGene",
  public = list(
    initialize = function(lmm, lmmToDataFrameMapper) {
      if (!"LMMAbstract" %in% class(lmm))
        stop("incompatible parameter type: the class type of lmm must be a subclass of LMMAbstract")
      if (!"LINCSLMMLmerToDataFrameMapper" %in% class(lmmToDataFrameMapper))
        stop("incompatible parameter type: the class type of lmmToDataFrameMapper must be a subclass of LMMToDataFrameMapperAbstract")
      private$lmm <- lmm
      private$fixed_effect <- as.character(terms(lmm$getFormula())[1][[3]])
      private$lmmToDataFrameMapper <- lmmToDataFrameMapper
    },
    compute = function(rna_data_metadata, gene_id = NA, sample_name_column_name = "sample_name") {
      if (obj_is_na(gene_id)) {
        gene_id_prn <- ""
      }else {
        gene_id_prn <- paste0(" ", gene_id)
      }
      dgrpLogger$log(sprintf("start differential gene expression computation for gene: %s", gene_id_prn))
      startTime <- Sys.time()
      differentialExpression <- private$lmm$compute(rna_data_metadata)
      differentialExpression <- private$lmmToDataFrameMapper$map(differentialExpression, gene_id, private$fixed_effect, sample_name_column_name)
      totalTime <- Sys.time() - startTime
      dgrpLogger$log(sprintf("end gene differential expression computation%s, time: %s %s", gene_id_prn, totalTime, attr(totalTime, "units")))
      # force garbage collection to prevent out of memory
      gc()
      return(differentialExpression)
    }
  ),
  private = list(
    lmm = NA,
    fixed_effect = NA,
    lmmToDataFrameMapper = NA
  )
)
