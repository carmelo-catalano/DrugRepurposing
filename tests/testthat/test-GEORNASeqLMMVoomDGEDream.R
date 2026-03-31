library(testthat)

# setup
geoRNASeqLMMMetadataLoader <- GEORNASeqLMMMetadataLoader$new()
lmmGeneFilter <- LMMLowCountsGeneFilter$new(random_effects_level_threshold = 0)
sut <- GEORNASeqLMMVoomDGEDream$new(lmmGeneFilter)

# given
rna_seq_metadata_filename <- absolute_path_filename("unit_test_data/voom/gse153960_metadata.csv")
rna_seq_data_filename <- absolute_path_filename("unit_test_data/voom/GSE153960_raw_counts_GRCh38.p13_NCBI_first_50.tsv")
sample_statuses_to_be_tested <- c("Non-Neurological Control", "ALS Spectrum MND")
sample_statuses_map <- c("Control", "als")
formula <- ~tissue_status + (1 | tissue)
sample_status_column_name <- "tissue_status"
sample_id_column_name <- "accession"
additional_columns <- "tissue"
random_effect_column_names <- additional_columns

rna_seq_metadata <- geoRNASeqLMMMetadataLoader$load(rna_seq_metadata_filename, sample_status_column_name, sample_statuses_to_be_tested, sample_statuses_map, sample_id_column_name, additional_columns)

expected <- absolute_path_readRDS("unit_test_data/voom/GEORNASeqLMMVoomDGEDream_expected.Rds")

# when
result <- sut$compute(
  rna_seq_data_filename,
  rna_seq_metadata,
  formula,
  random_effect_column_names,
  sample_status_column_name,
  filter_by_protein_coding = FALSE
)

result$p.value <- NULL
result$adj.p.value <- NULL

# then
test_that("test-GEORNASeqLMMVoomDGEDream", {
  expect_equal(result, expected, tolerance = 0.0005)
}
)
