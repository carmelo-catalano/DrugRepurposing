LINCSMetadataSetuperAbstract <- R6Class(
  "LINCSMetadataSetuperAbstract",
  public = list(
    setup = function(perturbation_time, drugs_filter) {
      stop("I'm an abstract method, please implement me")
    }
  )
)