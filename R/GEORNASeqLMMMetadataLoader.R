GEORNASeqLMMMetadataLoader <- R6Class(
  "GEORNASeqLMMMetadataLoader",
  public = list(
    initialize = function() {
      private$geoRNASeqLMMMetadataMapper <- GEORNASeqLMMMetadataMapper$new()
    },
    load = function(rna_seq_metadata_filename, sample_status_column_name, sample_statuses_to_be_tested, sample_statuses_map, sample_id_column_name = "accession", additional_columns = NA) {
      rna_seq_metadata <- read_delim(rna_seq_metadata_filename, delim = ";")
      sizes <- dim(rna_seq_metadata)
      dgrpLogger$log(sprintf("RNA Seq metadata loaded, size: %s X %s", sizes[1], sizes[2]))
      rna_seq_metadata <- private$geoRNASeqLMMMetadataMapper$map(rna_seq_metadata, sample_status_column_name, sample_statuses_to_be_tested, sample_statuses_map, sample_id_column_name, additional_columns)
      return(rna_seq_metadata)
    }
  ),
  private = list(
    geoRNASeqLMMMetadataMapper = NA
  )
)