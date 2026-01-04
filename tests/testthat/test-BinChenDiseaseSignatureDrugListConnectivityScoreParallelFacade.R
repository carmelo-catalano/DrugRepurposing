library(testthat)

# setup
diseaseSignatureEstimateMapper <- DiseaseSignatureEstimateMapper$new()
drugSignatureLoader <- DrugSignatureLoaderByDrugName$new(paste0(absolute_path_filename("unit_test_data/connectivity_score/drug_dge/"), "/"), "t.value_6h")
sut <- BinChenDiseaseSignatureDrugListConnectivityScoreParallelFacade$new(drugSignatureLoader)

# given
disease_signature <- absolute_path_readRDS("unit_test_data/connectivity_score/ipf_dge.Rds")
LINCS_bing <- package_readRDS("extdata/LINCS_gene_info.Rds")
LINCS_bing <- LINCS_bing[LINCS_bing$is_best_inferred_gene == 1, "gene_id"]
disease_signature <- subset(disease_signature, gene_id %in% LINCS_bing)
disease_signature$abs_t.value <- abs(disease_signature$t.value)
disease_signature <- disease_signature[order(disease_signature$abs_t.value, decreasing = T),]
disease_signature <- disease_signature[1:150, , drop = FALSE]

drugs <- data.frame(name = c("A-23187", "AG-490", "AKT-inhibitor-1-2", "AM-404",
                             "A-443644", "AG-494", "AG-957"))
drugs$filename <- drugs$name
disease_signature <- diseaseSignatureEstimateMapper$map(disease_signature)
expected <- absolute_path_readRDS("unit_test_data/connectivity_score/DiseaseDrugConnectivityScoreByBinChen_expected.Rds")

# when
result <- sut$compute(disease_signature, drugs, length(LINCS_bing), random_distribution_size = 10, disease_name = "IPF")
result$p.value <- NULL
result$adj.p.value <- NULL

# then
test_that("test-BinChenDiseaseSignatureDrugListConnectivityScoreParallelFacade", {
  expect_equal(result, expected)
}
)
