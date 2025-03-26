library(testthat)

# setup
sut <- ADJPValueAndFCThresholdSignatureMapper$new()

# given
disease_dge <- package_readRDS("test/connectivity_score/ipf_dge.Rds")
expected <- package_readRDS("test/connectivity_score/ADJPValueAndFCThresholdSignatureMapper2_expected.Rds")

# when
result <- sut$map(disease_dge)

# then
test_that("test-ADJPValueAndFCThresholdSignatureMapper2", {
  expect_identical(result, expected)
}
)
