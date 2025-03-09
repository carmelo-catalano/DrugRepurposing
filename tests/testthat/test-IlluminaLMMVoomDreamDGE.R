library(testthat)

# setup
sut <- IlluminaLMMVoomDreamDGE$new()

# given
rna_seq_metadata_filename <- absolute_package_filename("test/voom/gse153960_metadata.csv")
rna_seq_data_filename <- absolute_package_filename("test/voom/GSE153960_raw_counts_GRCh38.p13_NCBI_first_50.tsv")
tissue_statuses_to_be_tested <- c("Non-Neurological Control", "ALS Spectrum MND")
tissue_statuses_map <- c("Control", "als")
formula <- ~tissue_status + (1 | tissue)
tissue_status_field_name <- "tissue_status"
sample_id_field_name <- "accession"
additional_fields <- "tissue"
expected <- package_readRDS("test/voom/IlluminaLMMVoomDreamDGE_expected.Rds")

# when
result <- sut$compute(
  rna_seq_data_filename,
  rna_seq_metadata_filename,
  formula,
  tissue_status_field_name,
  tissue_statuses_to_be_tested,
  tissue_statuses_map,
  sample_id_field_name,
  additional_fields,
  filter_by_protein_coding = F
)
result$p.value <- NULL
result$adj.p.value <- NULL

# then
test_that("test-IlluminaLMMVoomDreamDGE", {
  expect_equal(result, expected, tolerance = 0.0005)
}
)
