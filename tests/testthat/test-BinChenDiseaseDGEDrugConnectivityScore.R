library(testthat)

# setup
sut <- BinChenDiseaseDGEDrugConnectivityScore$new()

# given
disease_dge <- absolute_path_readRDS("unit_test_data/connectivity_score/ipf_dge.Rds")
drug_dge <- absolute_path_readRDS("unit_test_data/connectivity_score/drug_dge/A-23187.Rds")

# when
result <- sut$compute(
  disease_dge, drug_dge, drug_dge_t_value_column_name = "t.value_6h", compute_p_value = F
)

# then
test_that("test-BinChenDiseaseDGEDrugConnectivityScore", {
  expect_equal(result, -0.02456061128210001998)
}
)
