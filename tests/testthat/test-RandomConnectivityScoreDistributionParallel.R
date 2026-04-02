library(testthat)
skip_if(is_windows_os(), message = "RandomConnectivityScoreDistributionParallel is not supported on the Windows operating system, test skipped")

# setup
sut <- RandomConnectivityScoreDistributionParallel$new()

# given
n_genes_up <- 31
n_genes_down <- 19
n_genes <- 150
random_distribution_size_1 <- 233
random_distribution_size_2 <- 10
random_distribution_size_3 <- 80
random_distribution_size_4 <- 807
random_distribution_size_5 <- 2

# when
result_1 <- sut$compute(n_genes_up, n_genes_down, n_genes, random_distribution_size_1)
result_2 <- sut$compute(n_genes_up, n_genes_down, n_genes, random_distribution_size_2)
result_3 <- sut$compute(n_genes_up, n_genes_down, n_genes, random_distribution_size_3)
result_4 <- sut$compute(n_genes_up, n_genes_down, n_genes, random_distribution_size_4)
result_5 <- sut$compute(n_genes_up, n_genes_down, n_genes, random_distribution_size_5)

# then
test_that("test-RandomConnectivityScoreDistributionParallel", {
  expect_equal(length(result_1), random_distribution_size_1)
  expect_equal(length(result_2), random_distribution_size_2)
  expect_equal(length(result_3), random_distribution_size_3)
  expect_equal(length(result_4), random_distribution_size_4)
  expect_equal(length(result_5), random_distribution_size_5)
}
)
