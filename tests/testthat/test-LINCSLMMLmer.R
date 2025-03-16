library(testthat)

#setup
lincsMetadataSetuper <- LINCSMetadataSetuper$new()
lincsRDSDataLoader <- LINCSRDSDataLoader$new(absolute_package_directory(test_config$LINCS_splitted_level3_dir))
sut <- LINCSLMMLmer$new()

# given
gene_id <- "2101" # symbol "ESRRA"
metadata <- lincsMetadataSetuper$setup("24")
metadata <- metadata[3:50,]
rna_data_metadata <- lincsRDSDataLoader$load(gene_id, metadata)
expected <- package_readRDS("test/LMMDGE/LINCSLMMLmer_expected.Rds")

# when
result <- sut$compute(rna_data_metadata)
result_table <- coef(summary(result))

# then
test_that("test-LINCSLMMLmer", {
  expect_equal(result_table, expected)
}
)
