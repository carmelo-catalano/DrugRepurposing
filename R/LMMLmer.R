LMMLmer <- R6Class(
  "LMMLmer",
  inherit = LMMAbstract,
  public = list(
    initialize = function(formula) {
      private$formula <- formula
    },
    compute = function(rna_data_metadata) {
      return(
        lmer(private$formula, data = rna_data_metadata, control = lmerControl(calc.derivs = FALSE))
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