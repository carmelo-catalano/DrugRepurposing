IlluminaLMMRNASeqMetadataMapper <- R6Class(
  "IlluminaLMMRNASeqMetadataMapper",
  public = list(
    map = function(rna_seq_metadata, tissue_status_field_name, tissue_statuses_to_be_tested, tissue_statuses_map, accession_field_name = "accession", additional_fields = NA) {
      if (obj_is_na(additional_fields)) {
        fields <- c(accession_field_name, tissue_status_field_name)
      }else {
        fields <- c(accession_field_name, tissue_status_field_name, additional_fields)
      }
      rna_seq_metadata <- rna_seq_metadata[, fields]
      rna_seq_metadata <- subset(rna_seq_metadata, rna_seq_metadata[[tissue_status_field_name]] %in% tissue_statuses_to_be_tested)
      for (i in 1:length(tissue_statuses_to_be_tested)) {
        rna_seq_metadata[rna_seq_metadata == tissue_statuses_to_be_tested[i]] <- tissue_statuses_map[i]
      }
      colnames(rna_seq_metadata)[1] <- "sample"
      rna_seq_metadata$tissue_status <- factor(rna_seq_metadata$tissue_status, levels = tissue_statuses_map)
      return(rna_seq_metadata)
    }
  )
)
