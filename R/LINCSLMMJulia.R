LINCSLMMJulia <- R6Class(
  "LINCSLMMJulia",
  inherit = LMMAbstract,
  public = list(
    compute = function(rna_data_metadata) {
      return(
        julia_call("fit", julia_eval("LinearMixedModel"), config$LINCSLMMFormula, rna_data_metadata, REML = T)
      )
    },
    getFormula = function() {
      return(config$LINCSLMMFormula)
    }
  )
)
