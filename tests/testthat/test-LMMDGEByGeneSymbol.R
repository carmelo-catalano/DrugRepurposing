library(testthat)
library(R6)

# setup
lincsMetadataSetuper <- LINCSMetadataSetuper$new()
lincsRDSDataLoader <- LINCSRDSDataLoader$new(absolute_path_directory(test_config$LINCS_splitted_level3_dir))

lmm <- LINCSLMMLmer$new()
lmmToDataFrameMapper <- LMMLmerToDataFrameMapper$new()
sut <- LMMDGEByGene$new(lmm, lmmToDataFrameMapper)

# given
gene_id <- "780"
gene_symbol <- "DDR1"
drugs_filter <- c("AM-251", "AM-404", "AM-580", "aminoglutethimide", "aminopurvalanol-a")
metadata <- lincsMetadataSetuper$setup("6", drugs_filter)
rna_data_metadata <- lincsRDSDataLoader$load(gene_id, metadata)
expected <- absolute_path_readRDS("unit_test_data/LMMDGE/LMMDGEByGeneSymbol_expected.Rds")

# when
result <- sut$compute(rna_data_metadata, gene_symbol, "drug")

# then
test_that("test-LMMDGEByGeneSymbol", {
  expect_equal(result, expected)
}
)
