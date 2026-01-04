library(testthat)
Sys.setlocale(locale = "C")

# setup
sut <- LINCSMetadataSetuper$new()

# given
selected_pert_time <- "6"
expected <- absolute_path_readRDS("unit_test_data/LMMDGE/LINCSMetadataSetuper6hExpected.Rds")

# when
result <- sut$setup(selected_pert_time)

# then
test_that("test-LINCSMetadataSetuper6h", {
  expect_identical(result, expected)
}
)
