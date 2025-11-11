library(testthat)
Sys.setlocale(locale = "C")

# setup
sut <- LINCSRDSLMMDrugDGELmer$new(absolute_package_directory(test_config$LINCS_splitted_level3_dir), absolute_package_directory(test_config$LINCS_dge_output_dir))

# given
gene_list <- "780" # symbol "DDR1"
drugs_filter <- c("AM-251", "AM-404", "AM-580", "aminoglutethimide", "aminopurvalanol-a")
perturbation_times <- "6"

expected <- package_readRDS(paste0(test_config$LINCS_expected_dge_dir, "780_6h-expected.Rds"))

# when
sut$compute(perturbation_times, gene_list, drugs_filter)

# then
result <- package_readRDS(paste0(test_config$LINCS_dge_output_dir, "780_6h.Rds"))

test_that("test-LINCSRDSLMMDrugDGELmer", {
  expect_equal(result, expected)
}
)


