library(testthat)

# setup
sut <- ADJPValueAndFCThresholdSignatureMapper$new(0.001, 3)

# given
disease_dge <- package_readRDS("test/connectivity_score/ipf_dge.Rds")
expected <- package_readRDS("test/connectivity_score/ADJPValueAndFCThresholdSignatureMapper_expected.Rds")

# when
result <- sut$map(disease_dge)

# then
test_that("test-ADJPValueAndFCThresholdSignatureMapper", {
  expect_identical(result, expected)
}
)
