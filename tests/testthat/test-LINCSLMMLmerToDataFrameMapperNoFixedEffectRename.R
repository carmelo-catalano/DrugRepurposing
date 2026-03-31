library(testthat)

#setup
lincsMetadataSetuper <- LINCSMetadataSetuper$new()
lincsRDSDataLoader <- LINCSRDSDataLoader$new(absolute_path_directory(test_config$LINCS_splitted_level3_dir))
sut <- LINCSLMMLmerToDataFrameMapper$new()

# given
gene_id <- "2101" # symbol "ESRRA"
computation_number <- 1
experiments_metadata <- lincsMetadataSetuper$setup("24")
experiments_metadata <- experiments_metadata[3:50,]
rna_data_metadata <- lincsRDSDataLoader$load(gene_id, experiments_metadata)
LMM_output <- lmer(gene_expression ~ pert_iname + (1 | cell_id) + (1 | rna_plate), data = rna_data_metadata, control = lmerControl(calc.derivs = FALSE))
expected <- absolute_path_readRDS("unit_test_data/LMMDGE/LINCSLMMLmerToDataFrameMapperNoFixedEffectRenameExpected.Rds")

# when
result <- sut$map(LMM_output, NA, "pert_iname", NA, "pert_iname")

# then
test_that("test-LINCSLMMLmerToDataFrameMapperNoFixedEffectRename", {
  expect_equal(result, expected)
}
)
