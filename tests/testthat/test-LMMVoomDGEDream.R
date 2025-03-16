library(testthat)

# setup
sut <- LMMVoomDGEDream$new()

# given
rna_seq <- package_readRDS("test/voom/als_NYGC_rna_seq.Rds")
expected <- package_readRDS("test/voom/LMMVoomDGEDream_expected.Rds")
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
