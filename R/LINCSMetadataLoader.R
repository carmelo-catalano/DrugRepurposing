library(R6)
library(readr)

LINCSMetadataLoader <- R6Class(
  "LINCSMetadataLoader",
  public = list(
    load = function() {
      return(package_readRDS(config$LINCS_metadata_RDS_filename))
    }
  )
)