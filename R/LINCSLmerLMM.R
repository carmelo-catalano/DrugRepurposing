library(R6)
library(lme4)

LINCSLmerLMM <- R6Class(
  "LINCSLmerLMM",
  inherit = LMMAbstract,
  public = list(
    compute = function(rna_data) {
      return(
        lmer(config$LINCSLMMFormula, data = rna_data, control = lmerControl(calc.derivs = FALSE))
      )
    }
  )
)