library(testthat)

# setup
sut <- BinChenCMapScoreByDrugDGE$new()
diseaseSignatureEstimateMapper <- DiseaseSignatureEstimateMapper$new()
downregulatedGeneFilter <- DownregulatedGeneFilter$new()
upregulatedGeneFilter <- UpregulatedGeneFilter$new()

# given
drug_signature <- absolute_path_readRDS("unit_test_data/connectivity_score/digoxin_drug_signature.Rds")

colnames(drug_signature)[1] <- "gene_id"
drug_signature <- drug_signature[, c("gene_id","t.value_6h"), drop = F]
colnames(drug_signature)[2] <- "estimate"

disease_signature <- absolute_path_readRDS("unit_test_data/connectivity_score/BLCA_dge.Rds")
disease_signature <- subset(disease_signature, gene_id %in% drug_signature$gene_id)
disease_signature$abs_t.value <- abs(disease_signature$t.value)
disease_signature <- disease_signature[order(disease_signature$abs_t.value, decreasing = T),]
disease_signature <- disease_signature[1:50, , drop = FALSE]

disease_signature <- diseaseSignatureEstimateMapper$map(disease_signature)
disease_up_regulated_genes <- upregulatedGeneFilter$filter(disease_signature)
disease_down_regulated_genes <- downregulatedGeneFilter$filter(disease_signature)

#when
result <- sut$compute(disease_down_regulated_genes, disease_up_regulated_genes, drug_signature)

# then
test_that("test-BinChenCMapScoreByDrugDGEBLCA", {
  expect_equal(result, -0.398634453781512632097872)
}
)
