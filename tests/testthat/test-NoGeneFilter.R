library(testthat)

# setup
sut <- NoGeneFilter$new()

# given
expected <- absolute_path_readRDS("unit_test_data/voom/als_NYGC_rna_seq.Rds")

# when
result <- sut$filter(expected, NA)

# then
test_that("test-NoGeneFilter", {
  expect_identical(result, expected)
}
)