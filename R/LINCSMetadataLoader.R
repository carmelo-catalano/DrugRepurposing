LINCSMetadataLoader <- R6Class(
  "LINCSMetadataLoader",
  public = list(
    load = function() {
      return(readRDS(LINCS_metadata_RDS_filename()))
    }
  )
)