library(testthat)
# source("modules/disease_signature/GeneFilterByProteinCoding.R")

# setup
sut <- GeneFilterByProteinCoding$new()

# given
gene_expressions <- data.frame(
  esperiment_code = c("DDR1", "AADAC", "PAX8", "ABCA1", "ABCA2", "ABCB7", "ABCF1",
                      "MIR2117HG", "FAM87B", "AARD", "A2M")
)

rownames(gene_expressions) <- c("780", "13", "7849", "19", "20", "22", "23", "106660605", "400728", "441376", "2")
expected <- c("DDR1", "AADAC", "PAX8", "ABCA1", "ABCA2", "ABCB7", "ABCF1", "AARD", "A2M")

# when
result <- sut$filterById(gene_expressions)

# then
test_that("test-GeneFilterByProteinCodingById", {
  expect_identical(result, expected)
}
)