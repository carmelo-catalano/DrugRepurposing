library(testthat)

# setup
sut <- DichotomicVoomDifferentialExpression$new()

# given
gene_experiments_data <- package_readRDS("test/disease_signature/DiseaseSignature_gene_experiments_data.Rds")
expected <- package_readRDS("test/disease_signature/DiseaseSignature_expected.Rds")

# when
result <- sut$compute(gene_experiments_data)
result$p.value <- NULL
result$adj.p.value <- NULL

# then
test_that("test-DichotomicVoomDifferentialExpression", {
  expect_equal(result, expected)
}
)
