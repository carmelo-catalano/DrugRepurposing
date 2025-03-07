LMMFormatDataLoaderAbstract <- R6Class(
  "LMMFormatDataLoaderAbstract",
  public = list(
    load = function(gene_id, metadata) {
      stop("I'm an abstract method, implement me")
    }
  )
)
