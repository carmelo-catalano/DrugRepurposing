LINCSMetadataSetuperAbstract <- R6Class(
  "LINCSMetadataSetuperAbstract",
  public = list(
    setup = function(drug_perturbation_times, drugs_filter) {
      stop("I'm an abstract method, please implement me")
    }
  )
)