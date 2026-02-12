library(testthat)

# setup
sut <- GEORNASeqLMMMetadataLoader$new()

# given
rna_seq_metadata_filename <- absolute_path_filename("unit_test_data/voom/gse153960_metadata.csv")
sample_status_column_name <- "tissue_status"
sample_statuses_to_be_tested <- c("Non-Neurological Control", "ALS Spectrum MND")
sample_statuses_map <- c("Control", "als")
sample_id_column_name <- "accession"
additional_columns <- "tissue"

expected <- absolute_path_readRDS("unit_test_data/loader/GEORNASeqLMMMetadataLoader_expected.Rds")

# when
result <- sut$load(
  rna_seq_metadata_filename,
  sample_status_column_name,
  sample_statuses_to_be_tested,
  sample_statuses_map,
  sample_id_column_name,
  additional_columns
)

# then
test_that("test-GEORNASeqLMMMetadataLoader", {
  expect_equal(result, expected)
}
)
