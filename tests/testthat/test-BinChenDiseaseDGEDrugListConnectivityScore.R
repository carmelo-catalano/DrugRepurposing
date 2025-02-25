library(testthat)

# setup
drugSignatureLoader <- DrugSignatureLoaderByDrugName$new(paste0(absolute_package_filename("test/connectivity_score/drug_dge/"), "/"), "t.value_6h")
sut <- BinChenDiseaseDGEDrugListConnectivityScore$new(drugSignatureLoader)

# given
disease_signature <- package_readRDS("test/connectivity_score/ipf_dge.Rds")
LINCS_bing <- package_readRDS("extdata/LINCS_gene_info.Rds")
LINCS_bing <- LINCS_bing[LINCS_bing$is_best_inferred_gene == 1, "gene_id"]

drugs <- data.frame(name = c("A-23187", "AG-490", "AKT-inhibitor-1-2", "AM-404",
                             "A-443644", "AG-494", "AG-957"))
drugs$filename <- drugs$name

expected <- package_readRDS("test/connectivity_score/OverallDiseaseDrugConnectivityScore_expected.Rds")
expected$gene_selection_strategy <- "150 MostSignificantGenes"
expected$drug_perturbation_time <- "6h"

# when
result <- sut$compute(disease_signature, drugs, LINCS_bing, 150, n_permutations = 10, disease_name = "IPF", drug_perturbation_time = "6h")

result$p.value <- NULL
result$adj.p.value <- NULL

# then
test_that("test-BinChenDiseaseDGEDrugListConnectivityScore", {
  expect_equal(result, expected)
}
)
