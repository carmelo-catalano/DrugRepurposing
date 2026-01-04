library(testthat)

# setup
sut <- LMMDGEDreamWithEBayes$new()

# given
rna_seq <- package_readRDS("test/voom/als_NYGC_rna_seq.Rds")
expected <- package_readRDS("test/LMMDGE/LMMDGEDreamWithEBayes_expected.Rds")
formula <- ~tissue_status + (1 | tissue)
rna_seq$data <- log2(rna_seq$data + 1)

# when
result <- sut$compute(rna_seq$data, rna_seq$metadata, formula)

# then
test_that("test-LMMDGEDreamWithEBayes", {
  expect_equal(result, expected, tolerance = 0.0005)
}
)
