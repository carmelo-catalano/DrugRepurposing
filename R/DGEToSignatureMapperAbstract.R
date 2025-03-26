DGEToSignatureMapperAbstract <- R6Class(
  "DGEToSignatureMapperAbstract",
  public = list(
    map = function(dge, paramter) {
      stop("I'm an abstract method, please implement me")
    },
    getSignatureType = function() {
      stop("I'm an abstract method, please implement me")
    }
  )
)