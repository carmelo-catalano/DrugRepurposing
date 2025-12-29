GEORNASeqLMMMetadataLoader <- R6Class(
  "GEORNASeqLMMMetadataLoader",
  public = list(
    initialize = function() {
      private$geoRNASeqLMMMetadataMapper <- GEORNASeqLMMMetadataMapper$new()
    },
    load = function(rna_seq_metadata_filename, tissue_status_field_name, tissue_statuses_to_be_tested, tissue_statuses_map, sample_id_field_name = "accession", additional_fields = NA) {
      rna_seq_metadata <- read_delim(rna_seq_metadata_filename, delim = ";")
      sizes <- dim(rna_seq_metadata)
      dgrpLogger$log(sprintf("RNA Seq metadata loaded, size: %s X %s", sizes[1], sizes[2]))
      rna_seq_metadata <- private$geoRNASeqLMMMetadataMapper$map(rna_seq_metadata, tissue_status_field_name, tissue_statuses_to_be_tested, tissue_statuses_map, sample_id_field_name, additional_fields)
      return(rna_seq_metadata)
    }
  ),
  private = list(
    geoRNASeqLMMMetadataMapper = NA
  )
)