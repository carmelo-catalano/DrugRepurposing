GEORNASeqLMMVoomDGECore <- R6Class(
  "GEORNASeqLMMVoomDGECore",
  inherit = GEORNASeqLMMVoomDGEAbstract,
  public = list(
    initialize = function(lmmVoomDGE, geneFilter = NA) {
      if (!"LMMVoomDGEAbstract" %in% class(lmmVoomDGE))
        stop("incompatible parameter type: the class type of lmmVoomDGE must be a subclass of LMMVoomDGEAbstract")
      private$lmmVoomDGE <- lmmVoomDGE
      private$geoRNASeqLMMLoader <- GEORNASeqLMMDataLoader$new(geneFilter)
    },
    compute = function(rna_seq_data_filename, rna_seq_metadata, formula, filter_by_protein_coding = FALSE) {
      startTime <- Sys.time()
      dgrpLogger$log(sprintf("start differential gene expression computation"))
      rna_seq_data <- private$geoRNASeqLMMLoader$load(rna_seq_data_filename, rna_seq_metadata)
      dge <- private$lmmVoomDGE$compute(rna_seq_data, rna_seq_metadata, formula, filter_by_protein_coding)
      totalTime <- Sys.time() - startTime
      dgrpLogger$log(sprintf("end differential gene expression computation, time: %s %s", totalTime, attr(totalTime, "units")))
      return(dge)
    }
  ),
  private = list(
    lmmVoomDGE = NA,
    geoRNASeqLMMLoader = NA
  )
)
