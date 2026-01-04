library(testthat)

# setup
sut <- ADJPValueAndFCThresholdSignatureMapper$new(0.001, 3)

# given
disease_dge <- absolute_path_readRDS("unit_test_data/connectivity_score/ipf_dge.Rds")
expected <- absolute_path_readRDS("unit_test_data/connectivity_score/ADJPValueAndFCThresholdSignatureMapper_expected.Rds")

# when
result <- sut$map(disease_dge)

# then
test_that("test-ADJPValueAndFCThresholdSignatureMapper", {
  expect_identical(result, expected)
}
)
