library(testthat)

# setup
sut <- LMMDGELmer$new()

# given
rna_seq <- absolute_path_readRDS("unit_test_data/voom/als_NYGC_rna_seq.Rds")
expected <- absolute_path_readRDS("unit_test_data/LMMDGE/LMMDGELmer_expected.Rds")
formula <- sample ~ tissue_status + (1 | tissue)
rna_seq$data <- log2(rna_seq$data + 1)

# when
result <- sut$compute(rna_seq$data, rna_seq$metadata, formula)

# then
test_that("test-LMMDGELmer", {
  expect_equal(result, expected)
}
)
