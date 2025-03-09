library(testthat)

# setup
sut <- RnaSeqSampleMapBuilder$new()

# given
sample_01_map <- "00011010X10XX11"
test_sample_name <- "als"
samples_list <- c("als", "als", "als", "Control", "Control", "als", "Control",
                  "als", "Control", "als", "Control", "Control")
sample_types <- factor(samples_list, levels = c("Control", "als"))
expected <- list(
  sample_types = sample_types,
  sample_positions = as.integer(c(1, 2, 3, 4, 5, 6, 7, 8, 10, 11, 14, 15))
)

# when
result <- sut$build(sample_01_map, test_sample_name)

# then
test_that("test-RnaSeqSampleMapBuilder", {
  expect_identical(result, expected)
}
)