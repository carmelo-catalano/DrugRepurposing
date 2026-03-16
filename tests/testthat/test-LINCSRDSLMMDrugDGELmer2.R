library(testthat)
Sys.setlocale(locale = "C")

# setup
sut <- LINCSRDSLMMDrugDGELmer$new(absolute_path_directory(test_config$LINCS_splitted_level3_dir), absolute_path_directory(test_config$LINCS_dge_output_dir))

# given
drugs_filter <- c("AM-251", "AM-404", "AM-580")
gene_list <- c("140", "54812")
drug_perturbation_times <- "6"

expected1 <- absolute_path_readRDS(paste0(test_config$LINCS_expected_dge_dir, "140_6h-expected.Rds"))
expected2 <- absolute_path_readRDS(paste0(test_config$LINCS_expected_dge_dir, "54812_6h-expected.Rds"))

# when
sut$compute(drug_perturbation_times, gene_list, drugs_filter)

# then
result1 <- absolute_path_readRDS(paste0(test_config$LINCS_dge_output_dir, "140_6h.Rds"))
result2 <- absolute_path_readRDS(paste0(test_config$LINCS_dge_output_dir, "54812_6h.Rds"))

test_that("test-LINCSRDSLMMDrugDGELmer2", {
  expect_equal(result1, expected1)
  expect_equal(result2, expected2)
}
)


