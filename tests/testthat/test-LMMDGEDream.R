library(testthat)

# setup
sut <- LMMDGEDream$new()

# given
rna_seq <- absolute_path_readRDS("unit_test_data/voom/als_NYGC_rna_seq.Rds")
expected <- absolute_path_readRDS("unit_test_data/LMMDGE/LMMDGEDream_expected.Rds")
formula <- ~tissue_status + (1 | tissue)
rna_seq$data <- log2(rna_seq$data + 1)

# when
result <- sut$compute(rna_seq$data, rna_seq$metadata, formula)

# then
test_that("test-LMMDGEDream", {
  expect_equal(result, expected, tolerance = 0.0005)
}
)
