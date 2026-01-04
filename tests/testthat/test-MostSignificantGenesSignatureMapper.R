library(testthat)

# setup
sut <- MostSignificantGenesSignatureMapper$new()

# given
disease_dge <- absolute_path_readRDS("unit_test_data/connectivity_score/ipf_dge.Rds")
expected <- absolute_path_readRDS("unit_test_data/connectivity_score/MostSignificantGenesSignatureMapper_expected.Rds")

# when
result <- sut$map(disease_dge)

# then
test_that("test-MostSignificantGenesSignatureMapper", {
  expect_identical(result, expected)
}
)
