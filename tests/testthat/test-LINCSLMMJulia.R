library(testthat)

#setup
lincsMetadataSetuper <- LINCSMetadataSetuper$new()
lincsRDSDataLoader <- LINCSRDSDataLoader$new(absolute_package_directory(test_config$LINCS_splitted_level3_dir))
juliaSetuper <- JuliaSetuper$new()
juliaSetuper$setup()
sut <- LINCSLMMJulia$new()

# given
gene_id <- "2101" # symbol "ESRRA"
metadata <- lincsMetadataSetuper$setup("24")
metadata <- metadata[3:50,]
rna_data_metadata <- lincsRDSDataLoader$load(gene_id, metadata)
expected <- package_readRDS("test/LMMDGE/LMMJulia_expected.Rds")

# when
result <- sut$compute(rna_data_metadata)
result_table <- julia_call("coeftable", result)
result_table <- JuliaCall::field(result_table, "cols")

# then
test_that("test-LINCSLMMJulia", {
  expect_equal(result_table, expected)
}
)
