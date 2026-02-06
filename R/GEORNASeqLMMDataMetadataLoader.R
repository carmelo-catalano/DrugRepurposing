GEORNASeqLMMDataMetadataLoader <- R6Class(
  "GEORNASeqLMMDataMetadataLoader",
  public = list(
    initialize = function(lmmGeneFilter = NA) {
      if (!obj_is_na(lmmGeneFilter)) {
        if (!"LMMGeneFilterAbstract" %in% class(lmmGeneFilter))
          stop("the lmmGeneFilter instance must be of type LMMGeneFilterAbstract")
        private$lmmGeneFilter <- lmmGeneFilter
      }else {
        private$lmmGeneFilter <- LowCountsGeneFilter$new()
      }
      private$geoRNASeqLMMMetadataLoader <- GEORNASeqLMMMetadataLoader$new()
    },
    load = function(rna_seq_data_filename, rna_seq_metadata_filename, sample_status_column_name, sample_statuses_to_be_tested, sample_statuses_map, sample_id_column_name = "accession", additional_columns = NA) {
      rna_seq_metadata <- private$geoRNASeqLMMMetadataLoader$load(rna_seq_metadata_filename, sample_status_column_name, sample_statuses_to_be_tested, sample_statuses_map, sample_id_column_name, additional_columns)
      rna_seq_data <- as.matrix(data.table::fread(rna_seq_data_filename, header = TRUE, colClasses = "integer"), rownames = "GeneID")
      rna_seq_data <- rna_seq_data[, rna_seq_metadata$sample_id]
      sizes <- dim(rna_seq_data)
      dgrpLogger$log(sprintf("RNA Seq data loaded, size: %s X %s", sizes[1], sizes[2]))
      rna_seq_data <- private$lmmGeneFilter$filter(rna_seq_data, rna_seq_metadata$tissue_status)
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
    lmmGeneFilter = NA
  )
)