library(testthat)

# setup
sut <- DownregulatedGeneFilter$new()
diseaseSignatureEstimateMapper <- DiseaseSignatureEstimateMapper$new()

# given
disease_signature <- absolute_path_readRDS("unit_test_data/connectivity_score/ipf_dge.Rds")
disease_signature <- disease_signature[1:10,]
disease_signature <- diseaseSignatureEstimateMapper$map(disease_signature)
expected <- data.frame(gene_id = c("10003", "10002", "10004", "10001", "100037417", "10000"))

# when
result <- sut$filter(disease_signature)
rownames(result) <- NULL

# then
test_that("test-DownregulatedGeneFilter", {
  expect_identical(result, expected)
}
)
