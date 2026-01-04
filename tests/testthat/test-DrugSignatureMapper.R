library(testthat)

# setup
sut <- DrugSignatureMapper$new()

# given
drug_dge <- absolute_path_readRDS("unit_test_data/connectivity_score/drug_dge/A-23187.Rds")
expected <- absolute_path_readRDS("unit_test_data/connectivity_score/DrugSignatureMapper_expected.Rds")

# when
result <- sut$map(drug_dge, "t.value_6h")

# then
test_that("test-DrugSignatureMapper", {
  expect_equal(result, expected)
}
)