library(testthat)

#setup
lincsMetadataSetuper <- LINCSMetadataSetuper$new()
lincsRDSDataLoader <- LINCSRDSDataLoader$new(absolute_package_directory(test_config$LINCS_splitted_level3_dir))
juliaSetuper <- JuliaSetuper$new()
juliaSetuper$setup()
sut <- JuliaLMM$new(config$LINCSLMMFormula)

# given
gene_id <- "2101" # symbol "ESRRA"
metadata <- lincsMetadataSetuper$setup("24")
metadata <- metadata[3:50,]
rna_data <- lincsRDSDataLoader$load(gene_id, metadata)
expected <- package_readRDS("test/LMMDGE/JuliaLMMExpected.Rds")

# when
result <- sut$compute(rna_data)
result_table <- julia_call("coeftable", result)
result_table <- JuliaCall::field(result_table, "cols")

# then
test_that("test-JuliaLMM", {
  expect_identical(result_table, expected)
}
)