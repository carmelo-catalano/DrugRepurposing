LmerLMM <- R6Class(
  "LmerLMM",
  inherit = LMMAbstract,
  public = list(
    initialize = function(formula) {
      private$formula <- formula
    },
    compute = function(rna_data_metadata) {
      return(
        lmer(private$formula, data = rna_data_metadata, control = lmerControl(calc.derivs = FALSE))
      )
    }
  ),
  private = list(
    formula = NA
  )
)