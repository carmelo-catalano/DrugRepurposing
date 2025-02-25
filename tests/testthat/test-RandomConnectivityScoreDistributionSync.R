library(testthat)

# setup
sut <- RandomConnectivityScoreDistributionSync$new()

# given
n_genes_up <- 31
n_genes_down <- 19
n_genes <- 150
n_permutations <- 20

# when
result <- sut$compute(n_genes_up, n_genes_down, n_genes, n_permutations)

# than
test_that("test-RandomConnectivityScoreDistributionSync", {
  expect_equal(length(result), n_permutations)
}
)
