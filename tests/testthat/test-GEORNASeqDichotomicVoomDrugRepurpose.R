library(testthat)

# setup
sut <- GEORNASeqDichotomicVoomDrugRepurpose$new()

# given
drugs_vector <- c("A-23187", "A-443644", "AG-490", "AG-494",
                  "AG-957", "AKT-inhibitor-1-2", "AM-404")
drugs <- data.frame(name = drugs_vector, filename = drugs_vector)

drug_genes <- package_readRDS("extdata/LINCS_gene_info.Rds")
drug_genes <- subset(drug_genes, drug_genes$is_best_inferred_gene == 1)
drug_genes <- drug_genes$gene_id
expected <- package_readRDS("test/drug_repurpose/GEORNASeqDichotomicVoomDrugRepurpose_expected.Rds")

# when
result <- sut$compute(
  absolute_package_filename("test/voom/GSE92592_raw_counts_GRCh38.p13_NCBI.tsv.gz"),
  "000000000000000000001111111111111111111",
  "ipf",
  100,
  absolute_package_directory("test/connectivity_score/drug_dge/"),
  drugs,
  drug_genes,
  "t.value_6h",
  10,
  "6h",
  F,
  F
)

# then
result$p.value <- NULL
result$adj.p.value <- NULL
test_that("test-GEORNASeqDichotomicVoomDrugRepurpose", {
  expect_equal(result, expected)
}
)