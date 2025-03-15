library(testthat)

# setup
sut <- LmerLMMVoomDGE$new()

# given
rna_seq <- package_readRDS("test/voom/als_NYGC_rna_seq.Rds")
expected <- package_readRDS("test/voom/LmerLMMVoomDGE_expected.Rds")
formula <- ~tissue_status + (1 | tissue)

# when
result <- sut$compute(rna_seq$data, rna_seq$metadata, formula)

# then
test_that("test-LmerLMMVoomDGE", {
  expect_equal(result, expected)
}
)
