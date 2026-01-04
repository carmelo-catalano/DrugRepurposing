library(testthat)

# setup
sut <- UpregulatedGeneFilter$new()
diseaseSignatureEstimateMapper <- DiseaseSignatureEstimateMapper$new()

# given
disease_signature <- absolute_path_readRDS("unit_test_data/connectivity_score/ipf_dge.Rds")
disease_signature <- disease_signature[1:10,]
disease_signature <- diseaseSignatureEstimateMapper$map(disease_signature)
expected <- data.frame(gene_id = c("1000", "1", "100", "10"))
rownames(expected) <- expected$gene

# when
result <- sut$filter(disease_signature)

# then
test_that("test-UpregulatedGeneFilter", {
  expect_identical(result, expected)
}
)