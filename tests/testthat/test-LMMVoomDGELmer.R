library(testthat)

# setup
sut <- LMMVoomDGELmer$new()

# given
rna_seq <- package_readRDS("test/voom/als_NYGC_rna_seq.Rds")
expected <- package_readRDS("test/voom/LMMVoomDGELmer_expected.Rds")
formula <- ~tissue_status + (1 | tissue)

# when
result <- sut$compute(rna_seq$data, rna_seq$metadata, formula)

# then
test_that("test-LMMVoomDGELmer", {
  expect_equal(result, expected)
}
)
