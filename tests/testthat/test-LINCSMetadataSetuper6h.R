library(testthat)
Sys.setlocale(locale = "C")

# setup
sut <- LINCSMetadataSetuper$new()

# given
selected_pert_time <- "6"
expected <- package_readRDS("test/LMMDGE/LINCSMetadataSetuper6hExpected.Rds")

# when
result <- sut$setup(selected_pert_time)

# then
test_that("test-LINCSMetadataSetuper6h", {
  expect_identical(result, expected)
}
)
