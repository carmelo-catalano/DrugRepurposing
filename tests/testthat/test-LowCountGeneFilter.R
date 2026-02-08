# setup
sut <- LowCountsGeneFilter$new()

# given
disease_rna_seq_filename <- absolute_path_filename("unit_test_data/voom/GSE92592_raw_counts_GRCh38.p13_NCBI.tsv.gz")
disease_rna_seq <- as.matrix(data.table::fread(disease_rna_seq_filename, header = T, colClasses = "integer"), rownames = "GeneID")
control <- rep('Control', 19)
disease <- rep('Disease', 20)
sample_statuses <- factor(c(control, disease), levels = c('Control', 'Disease'))
expected <- absolute_path_readRDS("unit_test_data/filter/LowCountsGeneFilter_expected.Rds")

# when
result <- sut$filter(disease_rna_seq, sample_statuses)

# then
test_that("test-LowCountsGeneFilter", {
  expect_equal(result, expected)
}
)
