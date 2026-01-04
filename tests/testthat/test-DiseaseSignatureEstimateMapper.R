library(testthat)

# setup
sut <- DiseaseSignatureEstimateMapper$new()

# given
disease_signature <- absolute_path_readRDS("unit_test_data/connectivity_score/BLCA_dge.Rds")
expected <- absolute_path_readRDS("unit_test_data/connectivity_score/DiseaseSignatureMapper_expected.Rds")

# when
result <- sut$map(disease_signature)

# then
test_that("test-DiseaseSignatureMapper", {
  expect_identical(result, expected)
}
)
