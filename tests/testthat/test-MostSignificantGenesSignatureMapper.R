library(testthat)

# setup
sut <- MostSignificantGenesSignatureMapper$new()

# given
disease_dge <- package_readRDS("test/connectivity_score/ipf_dge.Rds")
expected <- package_readRDS("test/connectivity_score/MostSignificantGenesSignatureMapper_expected.Rds")

# when
result <- sut$map(disease_dge)

# then
test_that("test-MostSignificantGenesSignatureMapper", {
  expect_identical(result, expected)
}
)
