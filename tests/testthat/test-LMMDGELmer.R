library(testthat)

# setup
sut <- LMMDGELmer$new()

# given
rna_seq <- package_readRDS("test/voom/als_NYGC_rna_seq.Rds")
expected <- package_readRDS("test/LMMDGE/LMMDGELmer_expected.Rds")
formula <- sample ~ tissue_status + (1 | tissue)
rna_seq$data <- log2(rna_seq$data + 1)

# when
result <- sut$compute(rna_seq$data, rna_seq$metadata, formula)

# then
test_that("test-LMMDGELmer", {
  expect_equal(result, expected)
}
)
