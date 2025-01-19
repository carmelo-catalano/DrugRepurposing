library(testthat)

# setup
sut <- GeneIdSymbolConverter$new()

# given
gene_id_list1 <- c("2049", "2101", "8717", "10594", "826", "1072", "4677")
gene_ensembl_id_list1  <- c("ENSG00000182580", "ENSG00000173153", "ENSG00000102871", "ENSG00000174231","ENSG00000126247", "ENSG00000172757", "ENSG00000134440")

# when
result1 <- sut$idToEnsemblId(gene_id_list1)
result2 <- sut$ensemblIdToId(gene_ensembl_id_list1)

# then
test_that("test-GeneIdSymbolConverter3", {
  expect_identical(result1, gene_ensembl_id_list1)
  expect_identical(result2, gene_id_list1)
}
)