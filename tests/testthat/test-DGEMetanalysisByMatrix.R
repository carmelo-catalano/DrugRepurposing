library(testthat)
Sys.setlocale(locale="C")

# setup
sut <- DGEMetanalysisByMatrix$new()

# given
A2M_2_drug_dge_6h <- absolute_path_readRDS( "unit_test_data/LMMDGE/metanalysis/A2M_2_6h.Rds")
A2M_2_drug_dge_24h <- absolute_path_readRDS( "unit_test_data/LMMDGE/metanalysis/A2M_2_24h.Rds")

expected <- absolute_path_readRDS("unit_test_data/LMMDGE/metanalysis/DGEMetanalysisMultiple_expected.Rds")

# when
result <- sut$compute(A2M_2_drug_dge_6h, A2M_2_drug_dge_24h)

# then
test_that("test-DGEMetanalysisByMatrix", {
  expect_equal(result, expected)
}
)