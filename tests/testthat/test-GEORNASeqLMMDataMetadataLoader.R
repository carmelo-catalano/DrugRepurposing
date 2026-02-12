library(testthat)

# setup
sut <- GEORNASeqLMMDataMetadataLoader$new()

# given
rna_seq_metadata_filename <- absolute_path_filename("unit_test_data/voom/gse153960_metadata.csv")
rna_seq_data_filename <- absolute_path_filename("unit_test_data/voom/GSE153960_raw_counts_GRCh38.p13_NCBI_first_50.tsv")
sample_statuses_to_be_tested <- c("Non-Neurological Control", "ALS Spectrum MND")
sample_statuses_map <- c("Control", "als")
sample_status_column_name <- "tissue_status"
sample_id_column_name <- "accession"
additional_columns <- "tissue"
random_effect_column_names <- additional_columns

expected <- absolute_path_readRDS("unit_test_data/loader/GEORNASeqLMMDataMetadataLoader_expected.Rds")

# when
result <- sut$load(
  rna_seq_data_filename,
  rna_seq_metadata_filename,
  random_effect_column_names,
  sample_status_column_name,
  sample_statuses_to_be_tested,
  sample_statuses_map,
  sample_id_column_name,
  additional_columns
)

# then
test_that("test-GEORNASeqLMMDataMetadataLoader", {
  expect_equal(result, expected)
}
)
