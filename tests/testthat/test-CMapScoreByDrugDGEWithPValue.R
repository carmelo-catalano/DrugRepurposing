library(testthat)

# setup
sut <- CMapScoreByDrugDGEWithPValue$new()
drugSignatureLoader <- DrugSignatureLoaderByFilename$new("t.value_6h")
diseaseSignatureEstimateMapper <- DiseaseSignatureEstimateMapper$new()
downregulatedGeneFilter <- DownregulatedGeneFilter$new()
upregulatedGeneFilter <- UpregulatedGeneFilter$new()

# given
drug_signature <- drugSignatureLoader$load(absolute_package_filename("test/connectivity_score/drug_dge/AG-957.Rds"))
disease_signature <- package_readRDS("test/connectivity_score/ipf_dge.Rds")
disease_signature <- subset(disease_signature, gene_id %in% drug_signature$gene_id)
disease_signature$abs_t.value <- abs(disease_signature$t.value)
disease_signature <- disease_signature[order(disease_signature$abs_t.value, decreasing = T),]
disease_signature <- disease_signature[1:150, , drop = FALSE]

disease_signature <- diseaseSignatureEstimateMapper$map(disease_signature)
disease_up_regulated_genes <- upregulatedGeneFilter$filter(disease_signature)
disease_down_regulated_genes <- downregulatedGeneFilter$filter(disease_signature)
random_connectivity_score_distribution <- package_readRDS("test/connectivity_score/random_connectivity_score_distribution.Rds")

#when
result <- sut$compute(disease_down_regulated_genes, disease_up_regulated_genes, drug_signature, random_connectivity_score_distribution)

# then
test_that("test-CMapScoreByDrugDGEWithPValue", {
  expect_equal(result, c(0.163037760756174654463990, 0.802830000000000043591797))
}
)
