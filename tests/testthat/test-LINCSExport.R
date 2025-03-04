library(testthat)
Sys.setlocale(locale = "C")

# setup
absolute_path_experiment_data_file <- "/Users/carmelocatalano/r-projects/tsr-system/data/LINCS-GSE92742/GSE92742_Broad_LINCS_Level3_INF_mlr12k_n1319138x12328.gctx"

sut <- LINCSExport$new(absolute_path_experiment_data_file)

# given
gene_ids <- c("22", "23", "25", "29")
perturbation_times <- c("24")

output_dir <- paste0(absolute_package_filename("test/LMMDGE/LINCS_export/output"), "/")
gene_expected_dir <- paste0(absolute_package_filename("test/LMMDGE/LINCS_export/expected"), "/")
expected22 <- readRDS(paste0(gene_expected_dir, "22.Rds"))
expected23 <- readRDS(paste0(gene_expected_dir, "23.Rds"))
expected25 <- readRDS(paste0(gene_expected_dir, "25.Rds"))
expected29 <- readRDS(paste0(gene_expected_dir, "29.Rds"))

# when
sut$export(gene_ids, perturbation_times, output_dir)

# then

test_that("test-LINCSExport", {
  expect_identical(expected22, readRDS(paste0(output_dir, "22.Rds")))
  expect_identical(expected23, readRDS(paste0(output_dir, "23.Rds")))
  expect_identical(expected25, readRDS(paste0(output_dir, "25.Rds")))
  expect_identical(expected29, readRDS(paste0(output_dir, "29.Rds")))
}
)
