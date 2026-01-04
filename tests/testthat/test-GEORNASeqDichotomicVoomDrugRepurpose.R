library(testthat)

# setup
drugSignatureLoaderByDrugName <- DrugSignatureLoaderByDrugName$new(drug_dge_dir = absolute_package_directory("unit_test_data/connectivity_score/drug_dge/"), t_value_column_name = "t.value_6h")
sut <- GEORNASeqDichotomicVoomDrugRepurpose$new(drugSignatureLoader = drugSignatureLoaderByDrugName)

# given
drugs_vector <- c("A-23187", "A-443644", "AG-490", "AG-494",
                  "AG-957", "AKT-inhibitor-1-2", "AM-404")
drugs <- data.frame(name = drugs_vector, filename = drugs_vector)

drug_genes <- package_readRDS("extdata/LINCS_gene_info.Rds")
drug_genes <- subset(drug_genes, drug_genes$is_best_inferred_gene == 1)
drug_genes <- drug_genes$gene_id
expected <- absolute_path_readRDS("unit_test_data/drug_repurpose/GEORNASeqDichotomicVoomDrugRepurpose_expected.Rds")

# when
result <- sut$compute(
  absolute_path_filename("unit_test_data/voom/GSE92592_raw_counts_GRCh38.p13_NCBI.tsv.gz"),
  "TTTTTTTTTTTTTTTTTTTTCCCCCCCCCCCCCCCCCCC",
  drugs,
  drug_genes,
  10,
  "ipf",
  "6h",
  F,
  F,
  100
)

# then
result$p.value <- NULL
result$adj.p.value <- NULL
test_that("test-GEORNASeqDichotomicVoomDrugRepurpose", {
  expect_equal(result, expected)
}
)
