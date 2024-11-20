library(testthat)

# setup
sut <- DiseaseSignature$new()

# given
gene_experiments_data <- package_readRDS("test/disease_signature/DiseaseSignature_gene_experiments_data.Rds")
expected <- package_readRDS("test/disease_signature/DiseaseSignature_expected.Rds")

# when
result <- sut$compute(gene_experiments_data, F)
result$p.value <- NULL
result$adj.p.value <- NULL

# then
test_that("test-DiseaseSignature", {
  expect_equal(result, expected)
}
)
