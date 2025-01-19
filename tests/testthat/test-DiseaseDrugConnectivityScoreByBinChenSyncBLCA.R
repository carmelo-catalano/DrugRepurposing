library(testthat)

library(R6)

LINCSDrugSignatureLoaderByDrugName <- R6Class(
  "LINCSDrugSignatureLoaderByDrugName",
  inherit = DrugSignatureLoaderAbstract,
  public = list(
    initialize = function(LINCS_drug_signature) {
      private$LINCS_drug_signature <- LINCS_drug_signature
    },
    load = function(drug_name) {
      drug_signature <- subset(private$LINCS_drug_signature, drug %in% drug_name)
      rownames(drug_signature) <- drug_signature$gene_id
      drug_signature <- drug_signature[, "t.value", drop = F]
      colnames(drug_signature) <- "estimate"
      return(drug_signature)
    }
  ),
  private = list(
    LINCS_drug_signature = NA
  )
)

# setup
LINCS_drug_signature <- package_readRDS("test/connectivity_score/fixed_LINCS_drugs_dge.Rds")
drugSignatureLoader <- LINCSDrugSignatureLoaderByDrugName$new(LINCS_drug_signature)
sut <- DiseaseDrugConnectivityScoreByBinChenSync$new(drugSignatureLoader)
diseaseSignatureEstimateMapper <- DiseaseSignatureEstimateMapper$new()

# given
LINCS_lm <- unique(LINCS_drug_signature$gene_id)
disease_signature <- package_readRDS("test/connectivity_score/BLCA_dge.Rds")
disease_signature <- subset(disease_signature, gene_id %in% LINCS_lm)
disease_signature$abs_t.value <- abs(disease_signature$t.value)
disease_signature <- disease_signature[order(disease_signature$abs_t.value, decreasing = T),]
disease_signature <- disease_signature[1:50, , drop = FALSE]

drugs <- data.frame(name = unique(LINCS_drug_signature$drug))
drugs$filename <- drugs$name
disease_signature <- diseaseSignatureEstimateMapper$map(disease_signature)
expected <- package_readRDS("test/connectivity_score/DiseaseDrugConnectivityScoreByBinChenBLCA_expected.Rds")

# when
result <- sut$compute(disease_signature, drugs, length(LINCS_lm), n_permutations = 10, disease_name = "BLCA")
result$p.value <- NULL
result$adj.p.value <- NULL

# then
test_that("test-DiseaseDrugConnectivityScoreByBinChenSyncBLCA", {
  expect_equal(result, expected)
}
)
