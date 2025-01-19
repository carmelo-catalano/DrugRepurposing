library(testthat)

# setup
sut <- GeneIdSymbolConverter$new()

# given
gene_symbol_list1 <- c("EPHB3", "ESRRA", "TRADD", "PRPF8", "CAPNS1", "CFL1", "NARS1")
expected1 <- c("2049", "2101", "8717", "10594", "826", "1072", "4677")
gene_symbol_list2 <- c("ESRRA", "EPHB3", "TRADD", "PRPF8", "CFL1", "NARS1", "CAPNS1")
expected2 <- c("2101", "2049", "8717", "10594", "1072", "4677", "826")

# when
result1 <- sut$symbolToId(gene_symbol_list1)
result2 <- sut$symbolToId(gene_symbol_list2)

# then
test_that("test-GeneIdSymbolConverter1", {
  expect_identical(result1, expected1)
  expect_identical(result2, expected2)
}
)