library(testthat)
Sys.setlocale(locale="C")

# setup
sut <- DGEMetanalysisByMatrix$new()

# given
A2M_2_drug_dge_6h <- package_readRDS( "test/LMMDGE/metanalysis/A2M_2_6h.Rds")
A2M_2_drug_dge_24h <- package_readRDS( "test/LMMDGE/metanalysis/A2M_2_24h.Rds")

expected <- package_readRDS("test/LMMDGE/metanalysis/DGEMetanalysisMultiple_expected.Rds")

# when
result <- sut$compute(A2M_2_drug_dge_6h, A2M_2_drug_dge_24h)

# then
test_that("test-DGEMetanalysisByMatrix", {
  expect_equal(result, expected)
}
)