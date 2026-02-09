LMMVoomDGEDreamWithEBayes <- R6Class(
  "LMMVoomDGEDreamWithEBayes",
  inherit = LMMVoomDGEAbstract,
  public = list(
    initialize = function() {
      private$lmmVoomDGEDream <- LMMVoomDGEDream$new(apply_EBayes = TRUE)
    },
    compute = function(rna_seq_data, rna_seq_metadata, formula, filter_by_protein_coding = FALSE) {
      return(private$lmmVoomDGEDream$compute(rna_seq_data, rna_seq_metadata, formula, filter_by_protein_coding))
    }
  ),
  private = list(
    lmmVoomDGEDream = NA
  )
)
