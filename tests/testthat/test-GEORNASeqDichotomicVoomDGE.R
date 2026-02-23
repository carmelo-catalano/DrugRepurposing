library(testthat)

Sys.setlocale(locale = "C")

# setup
genefilter <- LogarithmGeneFilter$new(threshold = 6)
sut <- GEORNASeqDichotomicVoomDGE$new(genefilter)

# given
disease_rna_seq_filename <- absolute_path_filename("unit_test_data/voom/GSE92592_raw_counts_GRCh38.p13_NCBI.tsv.gz")
disease_rna_seq_sample_01_map <- "TTTTTTTTTTTTTTTTTTTTCCCCCCCCCCCCCCCCCCC"

expected <- absolute_path_readRDS("unit_test_data/voom/GEORNASeqDichotomicVoomDGE_expected.Rds")

# when
result <- sut$compute(disease_rna_seq_filename, disease_rna_seq_sample_01_map)
result$p.value <- NULL
result$adj.p.value <- NULL

# then
test_that("test-GEORNASeqDichotomicVoomDGE", {
  expect_equal(result, expected)
}
)
