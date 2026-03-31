library(testthat)
skip_if_not(test_config$LINCS_GTX_tests_enabled, message = "LINCS GTX tests disabled, test skipped")
Sys.setlocale(locale = "C")

# setup
sut <- LINCSGCTXLMMDrugDGELmer$new(test_config$LINCS_gtx_database, absolute_path_directory(test_config$LINCS_dge_output_dir))

# given
gene_list <- c("780","2101") # symbol "DDR1"
drugs_filter <- c("AM-251", "AM-404", "AM-580", "aminoglutethimide", "aminopurvalanol-a")
drug_perturbation_times <- "6"

expected_780 <- absolute_path_readRDS(paste0(test_config$LINCS_expected_dge_dir, "780_6h-expected.Rds"))
expected_2101 <- absolute_path_readRDS(paste0(test_config$LINCS_expected_dge_dir, "2101_6h-expected-b.Rds"))

# when
sut$compute(drug_perturbation_times, gene_list, drugs_filter)

# then
result_780 <- absolute_path_readRDS(paste0(test_config$LINCS_dge_output_dir, "780_6h.Rds"))
result_2101 <- absolute_path_readRDS(paste0(test_config$LINCS_dge_output_dir, "2101_6h.Rds"))

test_that("test-LINCSGCTXLMMDrugDGELmer", {
  expect_equal(result_780, expected_780)
  expect_equal(result_2101, expected_2101)
}
)


