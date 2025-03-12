library(testthat)

# setup
sut <- GeneFilterByProteinCoding$new()

# given
expected <- data.frame(
  esperiment_code = c("DDR1", "WASH7P", "PAX8", "ABCA1", "ABCA2", "ABCB7", "ABCF1",
                      "MIR2117HG", "FAM87B", "LOC729737", "A2M")
)

rownames(expected) <- c("780", "653635", "7849", "19", "20", "22", "23", "106660605", "400728", "729737", "2")

# when
result <- sut$filterByIdOnCondition(expected, F)

# then
test_that("test-GeneFilterByProteinCodingByIdOnConditionFalse", {
  expect_identical(result, expected)
}
)