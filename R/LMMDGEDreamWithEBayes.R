LMMDGEDreamWithEBayes <- R6Class(
  "LMMDGEDreamWithEBayes",
  inherit = LMMDGEAbstract,
  public = list(
    initialize = function() {
      private$lmmDGEDream <- LMMDGEDream$new(applyEBayes = TRUE)
    },
    compute = function(rna_data, rna_metadata, formula, filter_by_protein_coding = FALSE) {
      return(private$lmmDGEDream$compute(rna_data, rna_metadata, formula, filter_by_protein_coding))
    }
  ),
  private = list(
    lmmDGEDream = NA
  )
)
