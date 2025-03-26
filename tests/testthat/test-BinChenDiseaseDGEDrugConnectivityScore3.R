library(testthat)

# setup
dgeToSignatureMapper <- ADJPValueAndFCThresholdSignatureMapper$new(adj.p.value_threshold = 0.05, DE_log2_FC_threshold = 2.0)
sut <- BinChenDiseaseDGEDrugConnectivityScore$new(dgeToSignatureMapper)

# given
disease_dge <- package_readRDS("test/connectivity_score/ipf_dge.Rds")
drug_dge <- package_readRDS("test/connectivity_score/drug_dge/A-23187.Rds")

# when
result <- sut$compute(
  disease_dge, drug_dge, drug_dge_t_value_column_name = "t.value_6h", compute_p_value = F
)

# then
test_that("test-BinChenDiseaseDGEDrugConnectivityScore3", {
  expect_equal(result[1], 0.0806509238019938)
}
)
