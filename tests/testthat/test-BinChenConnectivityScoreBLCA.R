library(testthat)

# setup
sut <- BinChenConnectivityScore$new()
drugSignatureLoader <- DrugSignatureLoaderByFilename$new("t.value_6h")
diseaseSignatureEstimateMapper <- DiseaseSignatureEstimateMapper$new()
downregulatedGeneFilter <- DownregulatedGeneFilter$new()
upregulatedGeneFilter <- UpregulatedGeneFilter$new()

# given
all_drug_signatures <- package_readRDS("test/connectivity_score/6h_LINCS_drugs_dge.Rds")
drug_signature <- subset(all_drug_signatures, drug %in% "digoxin")

rownames(drug_signature) <- drug_signature$gene
drug_signature <- drug_signature[, "t.value_6h", drop = F]
colnames(drug_signature) <- "estimate"

disease_signature <- package_readRDS("test/connectivity_score/BLCA_dge.Rds")
colnames(disease_signature)[1] <- "gene_id"
disease_signature <- subset(disease_signature, gene_id %in% rownames(drug_signature))
disease_signature$abs_t.value <- abs(disease_signature$t.value)
disease_signature <- disease_signature[order(disease_signature$abs_t.value, decreasing = T),]
disease_signature <- disease_signature[1:50, , drop = FALSE]

disease_signature <- diseaseSignatureEstimateMapper$map(disease_signature)
disease_up_regulated_genes <- upregulatedGeneFilter$filter(disease_signature)
disease_down_regulated_genes <- downregulatedGeneFilter$filter(disease_signature)

#when
result <- sut$compute(disease_down_regulated_genes, disease_up_regulated_genes, drug_signature)

# then
test_that("test-BinChenConnectivityScoreBLCA", {
  expect_equal(result, -0.398634453781512632097872)
}
)
