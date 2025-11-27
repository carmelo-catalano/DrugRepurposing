LMMJulia <- R6Class(
  "LMMJulia",
  inherit = LMMAbstract,
  public = list(
    initialize = function(formula) {
      private$formula <- formula
    },
    compute = function(rna_data_metadata) {
      return(
        julia_call("fit", julia_eval("LinearMixedModel"), private$formula, rna_data_metadata, REML = TRUE)
      )
    },
    getFormula = function() {
      return(private$formula)
    }
  ),
  private = list(
    formula = NA
  )
)
