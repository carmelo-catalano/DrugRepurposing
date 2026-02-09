GEORNASeqLMMMetadataMapper <- R6Class(
  "GEORNASeqLMMMetadataMapper",
  public = list(
    map = function(rna_seq_metadata, sample_status_column_name, sample_statuses_to_be_tested, sample_statuses_map, sample_id_column_name = "accession", additional_columns = NA) {
      if (obj_is_na(additional_columns)) {
        fields <- c(sample_id_column_name, sample_status_column_name)
      }else {
        fields <- c(sample_id_column_name, sample_status_column_name, additional_columns)
      }
      rna_seq_metadata <- rna_seq_metadata[, fields]
      rna_seq_metadata <- subset(rna_seq_metadata, rna_seq_metadata[[sample_status_column_name]] %in% sample_statuses_to_be_tested)
      for (i in 1:length(sample_statuses_to_be_tested)) {
        rna_seq_metadata[[sample_status_column_name]][rna_seq_metadata[[sample_status_column_name]] == sample_statuses_to_be_tested[i]] <- sample_statuses_map[i]
      }
      colnames(rna_seq_metadata)[1] <- "sample_id"
      rna_seq_metadata[[sample_status_column_name]] <- factor(rna_seq_metadata[[sample_status_column_name]], levels = sample_statuses_map)
      return(rna_seq_metadata)
    }
  )
)
