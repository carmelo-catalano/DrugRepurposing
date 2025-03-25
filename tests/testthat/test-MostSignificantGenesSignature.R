library(testthat)

# setup
sut <- MostSignificantGenesSignature$new()

# given
disease_dge <- package_readRDS("test/connectivity_score/ipf_dge.Rds")
expected <- package_readRDS("test/connectivity_score/MostSignificantGenesSignature_expected.Rds")

# when
result <- sut$compute(disease_dge, 100)

# then
test_that("test-MostSignificantGenesSignature", {
  expect_identical(result, expected)
}
)