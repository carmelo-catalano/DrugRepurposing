GEORNASeqLMMDataMetadataLoader <- R6Class(
  "GEORNASeqLMMDataMetadataLoader",
  public = list(
    initialize = function(geneFilter = NA) {
      if (!obj_is_na(geneFilter)) {
        if (!"GeneFilterAbstract" %in% class(geneFilter))
          stop("the geneFilter instance must be of type GeneFilterAbstract")
        private$geneFilter <- geneFilter
      }else {
        private$geneFilter <- LowCountsGeneFilter$new()
      }
      private$geoRNASeqLMMMetadataLoader <- GEORNASeqLMMMetadataLoader$new()
    },
    load = function(rna_seq_data_filename, rna_seq_metadata_filename, tissue_status_field_name, tissue_statuses_to_be_tested, tissue_statuses_map, sample_id_field_name = "accession", additional_fields = NA) {
      rna_seq_metadata <- private$geoRNASeqLMMMetadataLoader$load(rna_seq_metadata_filename, tissue_status_field_name, tissue_statuses_to_be_tested, tissue_statuses_map, sample_id_field_name, additional_fields)
      rna_seq_data <- as.matrix(data.table::fread(rna_seq_data_filename, header = TRUE, colClasses = "integer"), rownames = "GeneID")
      rna_seq_data <- rna_seq_data[, rna_seq_metadata$sample_id]
      sizes <- dim(rna_seq_data)
      dgrpLogger$log(sprintf("RNA Seq data loaded, size: %s X %s", sizes[1], sizes[2]))
      rna_seq_data <- private$geneFilter$filter(rna_seq_data, rna_seq_metadata$tissue_status)
      return(
        list(
          metadata = rna_seq_metadata,
          data = rna_seq_data
        )
      )
    }
  ),
  private = list(
    geoRNASeqLMMMetadataLoader = NA,
    geneFilter = NA
  )
)