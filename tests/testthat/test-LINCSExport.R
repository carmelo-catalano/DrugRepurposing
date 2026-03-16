library(testthat)
skip_if_not(test_config$LINCS_GTX_tests_enabled, message = "LINCS GTX tests disabled, test skipped")
Sys.setlocale(locale = "C")

# setup

sut <- LINCSExport$new(test_config$LINCS_gtx_database)

# given
gene_ids <- c("22", "23", "25", "29")
drug_perturbation_times <- c("24")

output_dir <- paste0(absolute_path_filename("unit_test_data/LMMDGE/LINCS_export/output"), "/")
gene_expected_dir <- paste0(absolute_path_filename("unit_test_data/LMMDGE/LINCS_export/expected"), "/")
expected22 <- readRDS(paste0(gene_expected_dir, "22.Rds"))
expected23 <- readRDS(paste0(gene_expected_dir, "23.Rds"))
expected25 <- readRDS(paste0(gene_expected_dir, "25.Rds"))
expected29 <- readRDS(paste0(gene_expected_dir, "29.Rds"))

# when
sut$export(gene_ids, drug_perturbation_times, output_dir)

# then

test_that("test-LINCSExport", {
  expect_identical(expected22, readRDS(paste0(output_dir, "22.Rds")))
  expect_identical(expected23, readRDS(paste0(output_dir, "23.Rds")))
  expect_identical(expected25, readRDS(paste0(output_dir, "25.Rds")))
  expect_identical(expected29, readRDS(paste0(output_dir, "29.Rds")))
}
)
