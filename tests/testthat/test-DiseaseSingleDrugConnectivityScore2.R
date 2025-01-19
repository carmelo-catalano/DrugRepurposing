library(testthat)

# setup
sut <- DiseaseSingleDrugConnectivityScore$new(T)

# given
disease_dge <- package_readRDS("test/connectivity_score/ipf_dge.Rds")
drug_dge <- package_readRDS("test/connectivity_score/drug_dge/A-23187.Rds")

# when
result <- sut$compute(disease_dge, drug_dge, 100, "t.value_6h", 100, T)

# then
test_that("test-DiseaseSingleDrugConnectivityScore2", {
  expect_equal(result[1], -0.02456061128210001998)
}
)
