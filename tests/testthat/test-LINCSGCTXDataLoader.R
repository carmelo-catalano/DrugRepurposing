library(testthat)

# setup
lincsMetadataSetuper <- LINCSMetadataSetuper$new()

sut <- LINCSGCTXDataLoader$new("/Users/carmelo.catalano/r-projects/LINCS/GSE92742_Broad_LINCS_Level3_INF_mlr12k_n1319138x12328.gctx")

# given
gene_id <- "2101"
experiments_metadata <- lincsMetadataSetuper$setup("24")
experiments_metadata <- experiments_metadata[3:50,]
expected_gene_expression <- package_readRDS("test/LMMDGE/LINCSRDSDataLoaderExpected.Rds")

# when
result <- sut$load("2101", experiments_metadata)
experiments_metadata$gene_expression <- expected_gene_expression

# then
test_that("test-LINCSGCTXDataLoader", {
  expect_identical(result, experiments_metadata)
}
)
