library(testthat)
# source("modules/disease_signature/GeneFilterByProteinCoding.R")

# setup
sut <- GeneFilterByProteinCoding$new()

# given
gene_expressions <- data.frame(
  esperiment_code = c("DDR1", "WASH7P", "PAX8", "ABCA1", "ABCA2", "ABCB7", "ABCF1",
                      "MIR2117HG", "FAM87B", "LOC729737", "A2M")
)

rownames(gene_expressions) <- c("DDR1", "WASH7P", "PAX8", "ABCA1", "ABCA2", "ABCB7", "ABCF1", "MIR2117HG", "FAM87B", "LOC729737", "A2M")
expected <- c("DDR1", "PAX8", "ABCA1", "ABCA2", "ABCB7", "ABCF1", "A2M")

# when
result <- sut$filterBySymbol(gene_expressions)

# then
test_that("GeneFilterByProteinCodingBySymbol", {
  expect_identical(result, expected)
}
)