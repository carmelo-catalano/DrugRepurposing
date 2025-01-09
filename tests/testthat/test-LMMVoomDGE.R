library(testthat)

# setup
sut <- LMMVoomDGE$new()

# given
rna_seq <- package_readRDS("test/DGE/als_NYGC_rna_seq.Rds")
expected <- package_readRDS("test/DGE/LMMVoomDGE_expected.Rds")
formula <- ~tissue_status + (1 | tissue)

# when
result <- sut$compute(rna_seq$data, rna_seq$metadata, formula)
result$p.value <- NULL
result$adj.p.value <- NULL

# then
test_that("test-LMMVoomDGE", {
  expect_equal(result, expected)
}
)
