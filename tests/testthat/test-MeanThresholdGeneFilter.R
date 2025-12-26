library(testthat)

# setup
sut <- MeanThresholdGeneFilter$new(1)

# given
input <- matrix(c(1, 1, 3, 4, 1, 2, 0.5, 0.7, 0.1, 3), nrow = 5, ncol = 2)
expected <- matrix(c(1, 3, 4, 1, 2, 0.7, 0.1, 3), nrow = 4, ncol = 2)

# when
result <- sut$filter(input, NA)

# then
test_that("test-MeanThresholdGeneFilter", {
  expect_identical(result, expected)
}
)
