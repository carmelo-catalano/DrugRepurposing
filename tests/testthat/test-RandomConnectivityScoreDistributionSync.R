library(testthat)

# setup
sut <- RandomConnectivityScoreDistributionSync$new()

# given
n_genes_up <- 31
n_genes_down <- 19
n_genes <- 150
random_distribution_size <- 20

# when
result <- sut$compute(n_genes_up, n_genes_down, n_genes, random_distribution_size)

# than
test_that("test-RandomConnectivityScoreDistributionSync", {
  expect_equal(length(result), random_distribution_size)
}
)
