library(testthat)
library(R6)

# setup
lincsMetadataSetuper <- LINCSMetadataSetuper$new()
lincsRDSDataLoader <- LINCSRDSDataLoader$new(absolute_package_directory(test_config$LINCS_splitted_level3_dir))

lmm <- LMMLmer$new(gene_expression ~ pert_iname + (1 | cell_id) + (1 | rna_plate))
lmmToDataFrameMapper <- LMMLmerToDataFrameMapper$new()
sut <- LMMDGEByGene$new(lmm, lmmToDataFrameMapper)

# given
gene_id <- "780" # symbol "DDR1"
drugs_filter <- c("AM-251", "AM-404", "AM-580", "aminoglutethimide", "aminopurvalanol-a")
metadata <- lincsMetadataSetuper$setup("6", drugs_filter)
rna_data_metadata <- lincsRDSDataLoader$load(gene_id, metadata)
expected <- package_readRDS("test/LMMDGE/LMMDGEByGene_expected.Rds")

# when
result <- sut$compute(rna_data_metadata, NA, "drug")

# then
test_that("test-LMMDGEByGene", {
  expect_equal(result, expected)
}
)
