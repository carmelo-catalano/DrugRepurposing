library(testthat)
skip_if_not(test_config$LINCS_GTX_tests_enabled, message = "LINCS GTX tests disabled, test skipped")
# setup
lincsMetadataSetuper <- LINCSMetadataSetuper$new()

sut <- LINCSGCTXDataLoader$new(test_config$LINCS_gtx_database)

# given
gene_id <- "2101"
experiments_metadata <- lincsMetadataSetuper$setup("24")
experiments_metadata <- experiments_metadata[3:50,]
expected_gene_expression <- absolute_path_readRDS("unit_test_data/LMMDGE/LINCSRDSDataLoaderExpected.Rds")

# when
result <- sut$load("2101", experiments_metadata)
experiments_metadata$gene_expression <- expected_gene_expression

# then
test_that("test-LINCSGCTXDataLoader", {
  expect_identical(result, experiments_metadata)
}
)
