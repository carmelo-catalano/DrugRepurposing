LINCSLmerLMM <- R6Class(
  "LINCSLmerLMM",
  inherit = LMMAbstract,
  public = list(
    compute = function(rna_data_metadata) {
      return(
        lmer(config$LINCSLMMFormula, data = rna_data_metadata, control = lmerControl(calc.derivs = FALSE))
      )
    }
  )
)