# setup
sut <- LMMLogarithmGeneFilter$new(logarithm_threshold = 2.2, random_effects_level_threshold = 2)
geoRNASeqLMMDataLoader <- GEORNASeqLMMDataLoader$new()
geoRNASeqLMMMetadataLoader <- GEORNASeqLMMMetadataLoader$new()

# given
rna_metadata_filename <- absolute_path_filename("unit_test_data/voom/gse153960_metadata.csv")
rna_seq_data_filename <- absolute_path_filename("unit_test_data/voom/GSE153960_raw_counts_GRCh38.p13_NCBI_first_50.tsv")
sample_statuses_to_be_tested <- c("Non-Neurological Control", "ALS Spectrum MND")
sample_statuses_map <- c("Control", "als")
sample_status_column_name <- "tissue_status"
sample_id_column_name <- "accession"
additional_columns <- c("tissue", "subject_id")
random_effect_column_name <- "tissue"
rna_metadata <- geoRNASeqLMMMetadataLoader$load(rna_metadata_filename, sample_status_column_name, sample_statuses_to_be_tested, sample_statuses_map, sample_id_column_name, additional_columns)
rna_seq_data <- geoRNASeqLMMDataLoader$load(rna_seq_data_filename, rna_metadata)
rna_data <- log2(rna_seq_data + 1)

expected <- absolute_path_readRDS("unit_test_data/filter/LMMLogarithmGeneFilter_expected.Rds")

# when
result <- sut$filter(rna_data, rna_metadata, random_effect_column_name)

# then
test_that("test-LMMLogarithmGeneFilter", {
  expect_equal(result, expected)
}
)
