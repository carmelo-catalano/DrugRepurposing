library(testthat)

Sys.setlocale(locale = "C")

# setup
genefilter <- LogarithmGeneFilter$new()
sut <- GEORNASeqDichotomicVoomDGE$new(genefilter)

# given
disease_rna_seq_filename <- absolute_package_filename("test/voom/GSE92592_raw_counts_GRCh38.p13_NCBI.tsv.gz")
disease_rna_seq_sample_01_map <- "000000000000000000001111111111111111111"

expected <- package_readRDS("test/voom/GEORNASeqDichotomicVoomDGE_expected.Rds")

# when
result <- sut$compute(disease_rna_seq_filename, disease_rna_seq_sample_01_map)
result$p.value <- NULL
result$adj.p.value <- NULL

# then
test_that("test-GEORNASeqDichotomicVoomDGE", {
  expect_equal(result, expected)
}
)
