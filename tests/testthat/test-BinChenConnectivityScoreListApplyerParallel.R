library(testthat)

skip_if(is_windows_os(), message = "BinChenConnectivityScoreListApplyerParallel is not supported on the Windows operating system, test skipped")

# setup
drugSignatureLoader <- DrugSignatureLoaderByDrugName$new(paste0(absolute_path_filename("unit_test_data/connectivity_score/drug_dge/"), "/"), "t.value_6h")
sut <- BinChenConnectivityScoreListApplyerParallel$new(drugSignatureLoader)

diseaseSignatureEstimateMapper <- DiseaseSignatureEstimateMapper$new()
downregulatedGeneFilter <- DownregulatedGeneFilter$new()
upregulatedGeneFilter <- UpregulatedGeneFilter$new()

# given
disease_signature <- absolute_path_readRDS("unit_test_data/connectivity_score/ipf_dge.Rds")
drug_signature <- absolute_path_readRDS("unit_test_data/connectivity_score/drug_dge/AG-957.Rds")
disease_signature <- subset(disease_signature, gene_id %in% drug_signature$gene_id)
disease_signature$abs_t.value <- abs(disease_signature$t.value)
disease_signature <- disease_signature[order(disease_signature$abs_t.value, decreasing = T),]
disease_signature <- disease_signature[1:150, , drop = FALSE]

disease_signature <- diseaseSignatureEstimateMapper$map(disease_signature)
disease_up_regulated_genes <- upregulatedGeneFilter$filter(disease_signature)
disease_down_regulated_genes <- downregulatedGeneFilter$filter(disease_signature)

drug_signatures <- data.frame(name = c("A-23187", "AG-490", "AKT-inhibitor-1-2", "AM-404",
                             "A-443644", "AG-494", "AG-957"))
drug_signatures$signature_reference <- drug_signatures$name
random_connectivity_score_distribution <- absolute_path_readRDS("unit_test_data/connectivity_score/random_connectivity_score_distribution.Rds")
expected <- absolute_path_readRDS("unit_test_data/connectivity_score/BinChenConnectivityScoreListApplyer_expected.Rds")

# when
result <- sut$compute(disease_down_regulated_genes, disease_up_regulated_genes, drug_signatures, random_connectivity_score_distribution)

# then
test_that("test-BinChenConnectivityScoreListApplyerParallel", {
  expect_equal(result, expected)
}
)
