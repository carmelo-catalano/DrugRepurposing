library(testthat)

# setup
sut <- DichotomicRNADataMapper$new()

# given
rna_seq_filename <- absolute_path_filename("unit_test_data/voom/GSE92592_raw_counts_GRCh38.p13_NCBI.tsv.gz")
rna_seq <- as.matrix(data.table::fread(rna_seq_filename, header = T, colClasses = "integer"), rownames = "GeneID")
sample_01_map <- ""
expected <- absolute_path_readRDS("unit_test_data/DGE/DichotomicRNADataMapper_expected.Rds")

# when
result <- tryCatch({ sut$map(rna_seq, sample_01_map)
}, error = function(e) {
  "error"
})

# then
test_that("test-DichotomicRNADataMapper", {
  expect_equal(result, "error")
}
)
