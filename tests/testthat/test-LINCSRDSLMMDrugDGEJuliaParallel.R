library(testthat)

# setup
sut <- LINCSRDSLMMDrugDGEJuliaParallel$new(
  absolute_package_directory(test_config$LINCS_splitted_level3_dir),
  absolute_package_directory(test_config$LINCS_dge_output_dir),
  15,
  2
)

# given
chunk1 <- list()
chunk1$perturbation_times <- "6"
chunk1$gene_list <- c("140", "780")
chunk1$drugs_filter <- c("AM-92016", "AMG-9810", "AMN-082")
chunk1$number <- 1

chunk2 <- list()
gene_list2 <- list()
gene_list2[1] <- "140"
gene_list2[2] <- "2597"
chunk2$perturbation_times <- "24"
chunk2$gene_list <- gene_list2
chunk2$drugs_filter <- c("AM-92016", "AMG-9810", "AMN-082")
chunk2$number <- 2

chunks <- list()
chunks[[1]] <- chunk1
chunks[[2]] <- chunk2

expected1 <- package_readRDS(paste0(test_config$LINCS_expected_parallel_dge_dir, "140_6h-expected.Rds"))
expected2 <- package_readRDS(paste0(test_config$LINCS_expected_parallel_dge_dir, "140_24h-expected.Rds"))
expected3 <- package_readRDS(paste0(test_config$LINCS_expected_parallel_dge_dir, "780_6h-expected.Rds"))
expected4 <- package_readRDS(paste0(test_config$LINCS_expected_parallel_dge_dir, "2597_24h-expected.Rds"))

# when
sut$process(chunks)

result1 <- package_readRDS(paste0(test_config$LINCS_dge_output_dir, "140_6h.Rds"))
result2 <- package_readRDS(paste0(test_config$LINCS_dge_output_dir, "140_24h.Rds"))
result3 <- package_readRDS(paste0(test_config$LINCS_dge_output_dir, "780_6h.Rds"))
result4 <- package_readRDS(paste0(test_config$LINCS_dge_output_dir, "2597_24h.Rds"))

# then

test_that("test-LINCSRDSLMMDrugDGEJuliaParallel", {
  expect_equal(result1, expected1, tolerance =1e-6)
  expect_equal(result2, expected2, tolerance =1e-6)
  expect_equal(result3, expected3, tolerance =1e-6)
  expect_equal(result4, expected4, tolerance =1e-6)
}
)
