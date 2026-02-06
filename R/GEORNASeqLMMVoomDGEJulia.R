GEORNASeqLMMVoomDGEJulia <- R6Class(
  "GEORNASeqLMMVoomDGEJulia",
  inherit = GEORNASeqLMMVoomDGEAbstract,
  public = list(
    initialize = function(lmmGeneFilter = NA) {
      private$lmmVoomDGE <- GEORNASeqLMMVoomDGECore$new(LMMVoomDGEJulia$new(), lmmGeneFilter)
    },
    compute = function(rna_seq_data_filename, rna_seq_metadata, formula, random_effect_column_namess, counts_filter_column_name = "sample_status", filter_by_protein_coding = FALSE) {
      return(private$lmmVoomDGE$compute(rna_seq_data_filename, rna_seq_metadata, formula, random_effect_column_namess, counts_filter_column_name, filter_by_protein_coding))
    }
  ),
  private = list(
    lmmVoomDGE = NA
  )
)