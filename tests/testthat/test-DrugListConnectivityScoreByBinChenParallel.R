library(testthat)

# setup
drugSignatureLoader <- DrugSignatureLoaderByDrugName$new(paste0(absolute_package_filename("test/connectivity_score/drug_dge/"), "/"), "t.value_6h")
sut <- DrugListConnectivityScoreByBinChenParallel$new(drugSignatureLoader)

diseaseSignatureEstimateMapper <- DiseaseSignatureEstimateMapper$new()
downregulatedGeneFilter <- DownregulatedGeneFilter$new()
upregulatedGeneFilter <- UpregulatedGeneFilter$new()
processorCores <- ProcessorCores$new()

# given
disease_signature <- package_readRDS("test/connectivity_score/ipf_dge.Rds")
drug_signature <- package_readRDS("test/connectivity_score/drug_dge/AG-957.Rds")
disease_signature <- subset(disease_signature, gene_id %in% drug_signature$gene_id)
disease_signature$abs_t.value <- abs(disease_signature$t.value)
disease_signature <- disease_signature[order(disease_signature$abs_t.value, decreasing = T),]
disease_signature <- disease_signature[1:150, , drop = FALSE]

disease_signature <- diseaseSignatureEstimateMapper$map(disease_signature)
disease_up_regulated_genes <- upregulatedGeneFilter$filter(disease_signature)
disease_down_regulated_genes <- downregulatedGeneFilter$filter(disease_signature)

drugs <- data.frame(name = c("A-23187", "AG-490", "AKT-inhibitor-1-2", "AM-404",
                             "A-443644", "AG-494", "AG-957"))
drugs$filename <- drugs$name
random_connectivity_score_distribution <- package_readRDS("test/connectivity_score/random_connectivity_score_distribution.Rds")
expected <- package_readRDS("test/connectivity_score/DrugListConnectivityScoreByBinChen_expected.Rds")
processorCores$initCores()

#when
result <- sut$compute(disease_down_regulated_genes, disease_up_regulated_genes, drugs, random_connectivity_score_distribution)

# then
test_that("test-DrugListConnectivityScoreByBinChenParallel", {
  expect_equal(result, expected)
}
)
