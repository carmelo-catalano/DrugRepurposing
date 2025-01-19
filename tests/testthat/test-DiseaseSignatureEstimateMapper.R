library(testthat)

# setup
sut <- DiseaseSignatureEstimateMapper$new()

# given
disease_signature <- package_readRDS("test/connectivity_score/BLCA_dge.Rds")
expected <- package_readRDS("test/connectivity_score/DiseaseSignatureMapper_expected.Rds")

# when
result <- sut$map(disease_signature)

# then
test_that("test-DiseaseSignatureMapper", {
  expect_identical(result, expected)
}
)
