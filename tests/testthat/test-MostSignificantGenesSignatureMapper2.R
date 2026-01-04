library(testthat)

# setup
sut <- MostSignificantGenesSignatureMapper$new(150)

# given
disease_dge <- absolute_path_readRDS("unit_test_data/connectivity_score/ipf_dge.Rds")
expected <- absolute_path_readRDS("unit_test_data/connectivity_score/MostSignificantGenesSignatureMapper2_expected.Rds")

# when
result <- sut$map(disease_dge)

# then
test_that("test-MostSignificantGenesSignatureMapper2", {
  expect_identical(result, expected)
}
)
