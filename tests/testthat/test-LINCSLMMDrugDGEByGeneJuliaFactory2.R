library(testthat)

# setup
lincsMetadataSetuper <- LINCSMetadataSetuper$new()
lincsRDSDataLoader <- LINCSRDSDataLoader$new(absolute_path_directory(test_config$LINCS_splitted_level3_dir))
LMMFormula <- gene_expression ~ pert_iname + (1 | cell_id)
sut <- LINCSLMMDrugDGEByGeneJuliaFactory$new()

# given
gene_id <- "2101"
gene_symbol <- "ESRRA"
metadata <- lincsMetadataSetuper$setup("24")
metadata <- metadata[3:50,]
rna_data_metadata <- lincsRDSDataLoader$load(gene_id, metadata)
expected <- absolute_path_readRDS("unit_test_data/LMMDGE/LINCSLMMDrugDGEByGeneJuliaFactory2_expected.Rds")

# when
drugDGE <- sut$create(4, LMMFormula)
result <- drugDGE$compute(rna_data_metadata, gene_symbol, "drug")

# then
test_that("test-LINCSLMMDrugDGEByGeneJuliaFactory2", {
  expect_equal(result, expected)
}
)
