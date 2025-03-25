library(testthat)

# setup
sut <- PValueAndFCThresholdSignature$new()

# given
disease_dge <- package_readRDS("test/connectivity_score/ipf_dge.Rds")
expected <- package_readRDS("test/connectivity_score/PValueAndFCThresholdSignature_expected.Rds")

# when
result <- sut$compute(disease_dge, 0.001, 3)

# then
test_that("test-PValueAndFCThresholdSignature", {
  expect_identical(result, expected)
}
)