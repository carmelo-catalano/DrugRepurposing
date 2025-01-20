library(testthat)

# setup
sut <- DichotomicVoomDGE$new()

# given
disease_name <- "ipf"
disease_rna_seq_filename <- absolute_package_filename("test/voom/GSE92592_raw_counts_GRCh38.p13_NCBI.tsv.gz")
disease_rna_seq <- as.matrix(data.table::fread(disease_rna_seq_filename, header = T, colClasses = "integer"), rownames = "GeneID")
disease_rna_seq_sample_01_map <- "000000000000000000001111111111111111111"

expected <- package_readRDS("test/voom/DichotomicVoomDGE_expected.Rds")

# when
result <- sut$compute(disease_rna_seq, disease_rna_seq_sample_01_map, disease_name, T)
result$p.value <- NULL
result$adj.p.value <- NULL

# then
test_that("test-DichotomicVoomDGE", {
  expect_equal(result, expected)
}
)
