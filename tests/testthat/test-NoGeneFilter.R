library(testthat)

# setup
sut <- NoGeneFilter$new()

# given
expected <- package_readRDS("test/voom/als_NYGC_rna_seq.Rds")

# when
result <- sut$filter(expected, NA)

# then
test_that("test-NoGeneFilter", {
  expect_identical(result, expected)
}
)