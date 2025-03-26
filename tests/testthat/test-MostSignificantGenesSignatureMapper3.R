library(testthat)

# setup
sut <- MostSignificantGenesSignatureMapper$new()

# given
disease_dge <- package_readRDS("test/connectivity_score/ipf_dge.Rds")
expected <- package_readRDS("test/connectivity_score/MostSignificantGenesSignatureMapper3_expected.Rds")

# when
result <- sut$map(disease_dge, 50)

# then
test_that("test-MostSignificantGenesSignatureMapper3", {
  expect_identical(result, expected)
}
)
