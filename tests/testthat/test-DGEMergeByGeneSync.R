library(testthat)

# setup
sut <- DGEMergeByGeneSync$new()

# given
gene_list <- c(140, 780, 2101, 2597, 54812)
drug_list <- c("3-matida", "AG-592", "AG-957")
expected1 <- package_readRDS(paste0(test_config$DGEMergeByGene_expected, "3-matida.Rds"))
expected2 <- package_readRDS(paste0(test_config$DGEMergeByGene_expected, "AG-592.Rds"))
expected3 <- package_readRDS(paste0(test_config$DGEMergeByGene_expected, "AG-957.Rds"))

# when
sut$merge(gene_list, drug_list, absolute_package_directory(test_config$LINCS_dge_dir), absolute_package_directory(test_config$DGEMergeByGene_output), "drug", "#id_6h.Rds")
result1 <- package_readRDS(paste0(test_config$DGEMergeByGene_output, "3-matida.Rds"))
result2 <- package_readRDS(paste0(test_config$DGEMergeByGene_output, "AG-592.Rds"))
result3 <- package_readRDS(paste0(test_config$DGEMergeByGene_output, "AG-957.Rds"))

# then
test_that("test-DGEMergeByGeneSync", {
  expect_identical(result1, expected1)
  expect_identical(result2, expected2)
  expect_identical(result3, expected3)
}
)
