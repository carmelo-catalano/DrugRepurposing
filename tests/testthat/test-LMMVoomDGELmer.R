library(testthat)

# setup
sut <- LMMVoomDGELmer$new()

# given
rna_seq <- absolute_path_readRDS("unit_test_data/voom/als_NYGC_rna_seq.Rds")
expected <- absolute_path_readRDS("unit_test_data/voom/LMMVoomDGELmer_expected.Rds")
formula <- ~tissue_status + (1 | tissue)

# when
result <- sut$compute(rna_seq$data, rna_seq$metadata, formula)

# then
test_that("test-LMMVoomDGELmer", {
  expect_equal(result, expected)
}
)
