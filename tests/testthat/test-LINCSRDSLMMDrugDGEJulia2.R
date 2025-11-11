library(testthat)
Sys.setlocale(locale = "C")

# setup
sut <- LINCSRDSLMMDrugDGEJulia$new(absolute_package_directory(test_config$LINCS_splitted_level3_dir), absolute_package_directory(test_config$LINCS_dge_output_dir), 4)

# given
drugs_filter <- c("AM-251", "AM-404", "AM-580")
gene_list <- c("140", "54812")
perturbation_times <- "24"

expected1 <- package_readRDS(paste0(test_config$LINCS_expected_dge_dir, "140_24h-expected.Rds"))
expected2 <- package_readRDS(paste0(test_config$LINCS_expected_dge_dir, "54812_24h-expected.Rds"))

# when
sut$compute("24", gene_list, drugs_filter)

# then
result1 <- package_readRDS(paste0(test_config$LINCS_dge_output_dir, "140_24h.Rds"))
result2 <- package_readRDS(paste0(test_config$LINCS_dge_output_dir, "54812_24h.Rds"))

test_that("test-LINCSRDSLMMDrugDGEJulia2", {
  expect_equal(result1, expected1)
  expect_equal(result2, expected2, tolerance =1e-6)
}
)


