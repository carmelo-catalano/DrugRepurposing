library(testthat)
Sys.setlocale(locale = "C")

# setup
sut <- LINCSRDSLMMDrugDGELmer$new(absolute_package_directory(test_config$LINCS_splitted_level3_dir), absolute_package_directory(test_config$LINCS_dge_output_dir))

# given
drugs_filter <- c("AM-251", "AM-404", "AM-580")
gene_list <- c("140", "54812")
perturbation_times <- "6"

expected1 <- package_readRDS(paste0(test_config$LINCS_expected_dge_dir, "ADORA3_140_6h-expected.Rds"))
expected2 <- package_readRDS(paste0(test_config$LINCS_expected_dge_dir, "AFTPH_54812_6h-expected.Rds"))

# when
sut$compute(perturbation_times, gene_list, drugs_filter)

# then
result1 <- package_readRDS(paste0(test_config$LINCS_dge_output_dir, "ADORA3_140_6h.Rds"))
result2 <- package_readRDS(paste0(test_config$LINCS_dge_output_dir, "AFTPH_54812_6h.Rds"))

test_that("test-LINCSRDSLMMDrugDGELmer2", {
  expect_equal(result1, expected1)
  expect_equal(result2, expected2)
}
)


