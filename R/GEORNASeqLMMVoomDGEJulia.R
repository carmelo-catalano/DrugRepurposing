GEORNASeqLMMVoomDGEJulia <- R6Class(
  "GEORNASeqLMMVoomDGEJulia",
  inherit = GEORNASeqLMMVoomDGEAbstract,
  public = list(
    initialize = function(geneFilter = NA) {
      private$lmmVoomDGE <- GEORNASeqLMMVoomDGECore$new(LMMVoomDGEJulia$new(), geneFilter)
    },
    compute = function(rna_seq_data_filename, rna_seq_metadata, formula, filter_by_protein_coding = FALSE) {
      return(private$lmmVoomDGE$compute(rna_seq_data_filename, rna_seq_metadata, formula, filter_by_protein_coding))
    }
  ),
  private = list(
    lmmVoomDGE = NA
  )
)