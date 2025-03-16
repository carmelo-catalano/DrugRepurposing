LINCSLMMLmer <- R6Class(
  "LINCSLMMLmer",
  inherit = LMMAbstract,
  public = list(
    compute = function(rna_data_metadata) {
      return(
        lmer(config$LINCSLMMFormula, data = rna_data_metadata, control = lmerControl(calc.derivs = FALSE))
      )
    },
    getFormula = function() {
      return(config$LINCSLMMFormula)
    }
  )
)