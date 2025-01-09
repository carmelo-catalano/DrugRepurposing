library(testthat)

# setup
sut <- DichotomicVoomDGE$new()

# given
gene_experiments_data <- package_readRDS("test/voom/gene_experiments_data.Rds")
expected <- package_readRDS("test/voom/DichotomicVoomDGE_expected.Rds")

# when
result <- sut$compute(gene_experiments_data)
result$p.value <- NULL
result$adj.p.value <- NULL

# then
test_that("test-DichotomicVoomDGE", {
  expect_equal(result, expected)
}
)
