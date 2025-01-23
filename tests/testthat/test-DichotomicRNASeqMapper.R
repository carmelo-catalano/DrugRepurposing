library(testthat)

# setup
logarithmGeneFilter <- LogarithmGeneFilter$new()
sut <- DicotomicRNASeqMapper$new(logarithmGeneFilter)

# given
test_sample_name <- "ipf"
rna_seq_filename <- absolute_package_filename("test/voom/GSE92592_raw_counts_GRCh38.p13_NCBI.tsv.gz")
rna_seq <- as.matrix(data.table::fread(rna_seq_filename, header = T, colClasses = "integer"), rownames = "GeneID")
sample_01_map <- "000000000000000000001111111111111111111"
expected <- package_readRDS("test/voom/DichotomicRNASeqMapper_expected.Rds")

# when
result <- sut$load(rna_seq, sample_01_map, test_sample_name)

# then
test_that("test-DichotomicRNASeqMapper", {
  expect_equal(result, expected)
}
)
