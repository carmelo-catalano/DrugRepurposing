library(testthat)

# setup
sut <- DrugSignatureMapper$new()

# given
drug_dge <- package_readRDS("test/connectivity_score/drug_dge/A-23187.Rds")
expected <- package_readRDS("test/connectivity_score/DrugSignatureMapper_expected.Rds")
# when
result <- sut$map(drug_dge, "t.value_6h")

# then
test_that("test-DrugSignatureMapper", {
  expect_equal(result, expected)
}
)