library(testthat)
Sys.setlocale(locale="C")

# setup
gene_computed_dir <- paste0(absolute_path_filename("unit_test_data/LMMDGE/LINCS_export/output"),"/")
gene_expected_dir <- paste0(absolute_path_filename("unit_test_data/LMMDGE/LINCS_export/expected"),"/")
lincsMetadataSetuper <- LINCSMetadataSetuper$new()
lincsGCTXDataRowLoader <- LINCSGCTXDataRowLoader$new(test_config$LINCS_gtx_database)
sut <- LINCSExportByGeneList$new(lincsGCTXDataRowLoader)

# given
bing_genes_file <- absolute_path_filename("unit_test_data/LMMDGE/LINCS_export/bing_genes.csv")
bing_genes <- read.table(bing_genes_file, sep = ";", header = T)
bing_genes <- bing_genes[, "pr_gene_id"]
experiments_meta_data <- lincsMetadataSetuper$setup(c("24"))
block_size <- 3
gene_start_index <- 10
expected22 <- readRDS(paste0(gene_expected_dir, "22.Rds"))
expected23 <- readRDS(paste0(gene_expected_dir, "23.Rds"))
expected25 <- readRDS(paste0(gene_expected_dir, "25.Rds"))
expected29 <- readRDS(paste0(gene_expected_dir, "29.Rds"))

# when
sut$export(bing_genes, experiments_meta_data, gene_start_index, gene_start_index + block_size,gene_computed_dir)

# then

test_that("test-LINCSExportByGeneList", {
  expect_identical(expected22, readRDS(paste0(gene_computed_dir, "22.Rds")))
  expect_identical(expected23, readRDS(paste0(gene_computed_dir, "23.Rds")))
  expect_identical(expected25, readRDS(paste0(gene_computed_dir, "25.Rds")))
  expect_identical(expected29, readRDS(paste0(gene_computed_dir, "29.Rds")))
}
)
