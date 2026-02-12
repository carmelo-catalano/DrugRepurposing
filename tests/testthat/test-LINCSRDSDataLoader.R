library(testthat)

# setup
lincsMetadataSetuper <- LINCSMetadataSetuper$new()

sut <- LINCSRDSDataLoader$new(absolute_path_directory(test_config$LINCS_splitted_level3_dir))

# given
gene_id <- "2101"
experiments_metadata <- lincsMetadataSetuper$setup("24")
experiments_metadata <- experiments_metadata[3:50,]
gene_expression <- absolute_path_readRDS("unit_test_data/loader/LINCSRDSDataLoaderExpected.Rds")

# when
result <- sut$load("2101", experiments_metadata)
experiments_metadata$gene_expression <- gene_expression

# then
test_that("test-LINCSRDSDataLoader", {
  expect_identical(result, experiments_metadata)
}
)
