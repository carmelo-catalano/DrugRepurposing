GEORNASeqLMMVoomDGECore <- R6Class(
  "GEORNASeqLMMVoomDGECore",
  inherit = GEORNASeqLMMVoomDGEAbstract,
  public = list(
    initialize = function(lmmVoomDGE, lmmGeneFilter = NA) {
      if (!"LMMVoomDGEAbstract" %in% class(lmmVoomDGE))
        stop("incompatible parameter type: the class type of lmmVoomDGE must be a subclass of LMMVoomDGEAbstract")
      if (!obj_is_na(lmmGeneFilter)) {
        if (!"LMMGeneFilterAbstract" %in% class(lmmGeneFilter))
          stop("the lmmGeneFilter instance must be of type LMMGeneFilterAbstract")
        private$lmmGeneFilter <- lmmGeneFilter
      }else {
        private$lmmGeneFilter <- LMMLowCountsGeneFilter$new()
      }
      private$lmmVoomDGE <- lmmVoomDGE
      private$geoRNASeqLMMLoader <- GEORNASeqLMMDataLoader$new()
    },
    compute = function(rna_seq_data_filename, rna_seq_metadata, formula, random_effect_column_names, counts_filter_column_name = "sample_status", filter_by_protein_coding = FALSE) {
      startTime <- Sys.time()
      dgrpLogger$log(sprintf("start differential gene expression computation"))
      rna_seq_data <- private$geoRNASeqLMMLoader$load(rna_seq_data_filename, rna_seq_metadata)
      rna_seq_data_metadata <- private$lmmGeneFilter$filter(rna_seq_data, rna_seq_metadata, random_effect_column_names, counts_filter_column_name)
      dge <- private$lmmVoomDGE$compute(rna_seq_data_metadata$rna_data, rna_seq_data_metadata$rna_metadata, formula, filter_by_protein_coding)
      totalTime <- Sys.time() - startTime
      dgrpLogger$log(sprintf("end differential gene expression computation, time: %s %s", totalTime, attr(totalTime, "units")))
      return(dge)
    }
  ),
  private = list(
    lmmVoomDGE = NA,
    lmmGeneFilter = NA,
    geoRNASeqLMMLoader = NA
  )
)
