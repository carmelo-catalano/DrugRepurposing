library(testthat)
Sys.setlocale(locale = "C")

# setup
sut <- LINCSRDSLMMDrugDGELmer$new(absolute_package_directory(test_config$LINCS_splitted_level3_dir), absolute_package_directory(test_config$LINCS_dge_output_dir))

# given
drugs_filter <- c("AM-251", "AM-404", "AM-580", "aminoglutethimide")
gene_list <- c("2101", "2597")
perturbation_times <- c("6", "24")

expected1 <- absolute_path_readRDS(paste0(test_config$LINCS_expected_dge_dir, "2101_6h-expected.Rds"))
expected2 <- absolute_path_readRDS(paste0(test_config$LINCS_expected_dge_dir, "2101_24h-expected.Rds"))
expected3 <- absolute_path_readRDS(paste0(test_config$LINCS_expected_dge_dir, "2597_6h-expected.Rds"))
expected4 <- absolute_path_readRDS(paste0(test_config$LINCS_expected_dge_dir, "2597_24h-expected.Rds"))

# when
sut$compute(perturbation_times, gene_list, drugs_filter)

# then
result1 <- absolute_path_readRDS(paste0(test_config$LINCS_dge_output_dir, "2101_6h.Rds"))
result2 <- absolute_path_readRDS(paste0(test_config$LINCS_dge_output_dir, "2101_24h.Rds"))
result3 <- absolute_path_readRDS(paste0(test_config$LINCS_dge_output_dir, "2597_6h.Rds"))
result4 <- absolute_path_readRDS(paste0(test_config$LINCS_dge_output_dir, "2597_24h.Rds"))

test_that("test-LINCSRDSLMMDrugDGELmer3", {
  expect_equal(result1, expected1)
  expect_equal(result2, expected2)
  expect_equal(result3, expected3)
  expect_equal(result4, expected4, tolerance = 1e-7)
}
)


