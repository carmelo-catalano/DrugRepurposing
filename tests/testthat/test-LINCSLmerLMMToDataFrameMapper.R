library(testthat)
library(lme4)

#setup
lincsMetadataSetuper <- LINCSMetadataSetuper$new()
lincsRDSDataLoader <- LINCSRDSDataLoader$new(absolute_package_directory(test_config$LINCS_splitted_level3_dir))
sut <- LINCSLmerLMMToDataFrameMapper$new()

# given
gene_id <- "2101" # symbol "ESRRA"
computation_number <- 1
experiments_metadata <- lincsMetadataSetuper$setup("24")
experiments_metadata <- experiments_metadata[3:50,]
rna_data <- lincsRDSDataLoader$load(gene_id, experiments_metadata)
LMM_output <- lmer(gene_expression ~ pert_iname + (1 | cell_id) + (1 | rna_plate), data = rna_data, control = lmerControl(calc.derivs = FALSE))
expected <- package_readRDS("test/LMMDGE/LINCSLmerMMToDataFrameMapperExpected.Rds")

# when
result <- sut$map(LMM_output)

# then
test_that("test-LINCSLmerLMMToDataFrameMapper", {
  expect_equal(result, expected)
}
)