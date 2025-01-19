library(testthat)

# setup
sut <- FilenameBuilder$new()

# when
result <- sut$valid_filename_pattern("abcf")

# then
test_that("test-FilenameBuilderValidFilenamePattern", {
  expect_identical(result, F)
}
)

# when
result <- sut$valid_filename_pattern("ab#idcf")

# then
test_that("test-FilenameBuilderValidFilenamePattern", {
  expect_identical(result, T)
}
)