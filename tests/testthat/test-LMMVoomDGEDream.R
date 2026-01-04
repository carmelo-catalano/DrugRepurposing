library(testthat)

# setup
sut <- LMMVoomDGEDream$new()

# given
rna_seq <- absolute_path_readRDS("unit_test_data/voom/als_NYGC_rna_seq.Rds")
expected <- absolute_path_readRDS("unit_test_data/voom/LMMVoomDGEDream_expected.Rds")
formula <- ~tissue_status + (1 | tissue)

# when
result <- sut$compute(rna_seq$data, rna_seq$metadata, formula)
result$p.value <- NULL
result$adj.p.value <- NULL

# then
test_that("test-LMMVoomDGEDream", {
  expect_equal(result, expected, tolerance = 0.00008)
}
)
