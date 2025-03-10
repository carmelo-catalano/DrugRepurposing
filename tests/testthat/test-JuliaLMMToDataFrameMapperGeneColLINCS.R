library(testthat)
library(JuliaCall)

#setup
lincsMetadataSetuper <- LINCSMetadataSetuper$new()
lincsRDSDataLoader <- LINCSRDSDataLoader$new(absolute_package_directory(test_config$LINCS_splitted_level3_dir))
sut <- JuliaLMMToDataFrameMapper$new()

# given
gene_id <- 2101 # "ESRRA"
metadata <- lincsMetadataSetuper$setup("24")
metadata <- metadata[3:50,]
rna_data_metadata <- lincsRDSDataLoader$load(gene_id, metadata)

julia_library("MixedModels")
LMM_output <- julia_call("fit", julia_eval("LinearMixedModel"), gene_expression ~ pert_iname + (1 | cell_id) + (1 | rna_plate), rna_data_metadata, show_value = F)
expected <- package_readRDS("test/LMMDGE/LINCSJuliaLMMToDataFrameMapperGeneColExpected.Rds")

# when
result <- sut$map(LMM_output, gene_id, "pert_iname", "drug")

# then
test_that("test-JuliaLMMToDataFrameMapperGeneColLINCS", {
  expect_equal(result, expected)
}
)
