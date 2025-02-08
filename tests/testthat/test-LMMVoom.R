library(testthat)

# setup
sut <- LMMVoom$new()

# given
rna_seq <- package_readRDS("test/voom/als_NYGC_rna_seq.Rds")
expected <- package_readRDS("test/voom/LMMVoom_expected.Rds")
formula <- ~tissue_status + (1 | tissue)
metadata <- rna_seq$metadata
metadata$sample <- NULL
rownames(metadata) <- rna_seq$metadata$sample
metadata <- as.matrix(metadata)

# when
result <- sut$compute(rna_seq$data, metadata, formula)

# then
test_that("test-LMMVoom", {
  expect_equal(result, expected)
}
)
