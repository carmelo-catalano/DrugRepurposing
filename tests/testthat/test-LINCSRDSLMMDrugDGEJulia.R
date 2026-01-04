library(testthat)

# setup
sut <- LINCSRDSLMMDrugDGEJulia$new(absolute_path_directory(test_config$LINCS_splitted_level3_dir), absolute_path_directory(test_config$LINCS_dge_output_dir), 4)

# given
gene_list <- "780" # symbol "DDR1"
drugs_filter <- c("AM-251", "AM-404", "AM-580", "aminoglutethimide", "aminopurvalanol-a")
perturbation_times <- "24"
expected <- absolute_path_readRDS(paste0(test_config$LINCS_expected_dge_dir, "780_24h-expected.Rds"))

# when
sut$compute(perturbation_times, gene_list, drugs_filter)

# then
result <- absolute_path_readRDS(paste0(test_config$LINCS_dge_output_dir, "780_24h.Rds"))

test_that("test-LINCSRDSLMMDrugDGEJulia", {
  expect_equal(result, expected, tolerance = 1e-6)
}
)
