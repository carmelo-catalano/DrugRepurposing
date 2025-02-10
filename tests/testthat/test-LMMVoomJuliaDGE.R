library(testthat)

# setup
sut <- LMMVoomJuliaDGE$new()

# given
rna_seq <- package_readRDS("test/voom/als_NYGC_rna_seq.Rds")
expected <- package_readRDS("test/voom/LMMVoomJuliaDGE_expected.Rds")
formula <- ~tissue_status + (1 | tissue)

# when
result <- sut$compute(rna_seq$data, rna_seq$metadata, formula)
result$p.value <- NULL
result$adj.p.value <- NULL

# then
test_that("test-LMMVoomJuliaDGE", {
  expect_equal(result, expected)
}
)
