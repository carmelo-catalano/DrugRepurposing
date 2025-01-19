library(testthat)

# setup
sut <- GeneIdSymbolConverter$new()

# given
gene_symbol_list1 <- c("EPHB3", "ESRRA", "TRADD", "PRPF8", "CAPNS1", "CFL1", "NARS1")
gene_ensembl_id_list1  <- c("ENSG00000182580", "ENSG00000173153", "ENSG00000102871", "ENSG00000174231","ENSG00000126247", "ENSG00000172757", "ENSG00000134440")

# when
result1 <- sut$symbolToEnsemblId(gene_symbol_list1)
result2 <- sut$ensemblIdToSymbol(gene_ensembl_id_list1)

# then
test_that("test-GeneIdSymbolConverter4", {
  expect_identical(result1, gene_ensembl_id_list1)
  expect_identical(result2, gene_symbol_list1)
}
)