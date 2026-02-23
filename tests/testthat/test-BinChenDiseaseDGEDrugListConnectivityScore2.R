library(testthat)

# setup
drugSignatureLoader <- DrugSignatureLoaderByDrugName$new(paste0(absolute_path_filename("unit_test_data/connectivity_score/drug_dge/"), "/"), "t.value_6h")
dgeToSignatureMapper <- ADJPValueAndFCThresholdSignatureMapper$new(0.005, 3)
sut <- BinChenDiseaseDGEDrugListConnectivityScore$new(drugSignatureLoader, dgeToSignatureMapper)

# given
disease_dge <- absolute_path_readRDS("unit_test_data/connectivity_score/ipf_dge.Rds")
LINCS_bing <- package_readRDS("extdata/LINCS_gene_info.Rds")
LINCS_bing <- LINCS_bing[LINCS_bing$is_best_inferred_gene == 1, "gene_id"]

drug_signatures <- data.frame(name = c("A-23187", "AG-490", "AKT-inhibitor-1-2", "AM-404",
                             "A-443644", "AG-494", "AG-957"))
drug_signatures$signature_reference <- drug_signatures$name

expected <- absolute_path_readRDS("unit_test_data/connectivity_score/BinChenDiseaseDGEDrugListConnectivityScore2_expected.Rds")

# when
result <- sut$compute(
  disease_dge = disease_dge,
  drug_signatures = drug_signatures,
  drugs_genes = LINCS_bing,
  disease_name = "IPF",
  random_distribution_size = 10,
  drug_perturbation_time = "6h"
)

result$p.value <- NULL
result$adj.p.value <- NULL

# then
test_that("test-BinChenDiseaseDGEDrugListConnectivityScore2", {
  expect_equal(result, expected)
}
)
