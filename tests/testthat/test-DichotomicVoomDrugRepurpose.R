library(testthat)

# setup
sut <- DichotomicVoomDrugRepurpose$new()

# given
drugs_vector <- c("A-23187", "A-443644", "AG-490", "AG-494",
                  "AG-957", "AKT-inhibitor-1-2", "AM-404")
drugs <- data.frame(name = drugs_vector, filename = drugs_vector)

drug_genes <- package_readRDS("extdata/LINCS_gene_info.Rds")
drug_genes <- subset(drug_genes, drug_genes$is_best_inferred_gene == 1)
drug_genes <- drug_genes$gene_id
disease_rna_seq_filename <- absolute_package_filename("test/voom/GSE92592_raw_counts_GRCh38.p13_NCBI.tsv.gz")
disease_rna_seq <- as.matrix(data.table::fread(disease_rna_seq_filename, header = T, colClasses = "integer"), rownames = "GeneID")

expected <- package_readRDS("test/drug_repurpose/DichotomicVoomDrugRepurpose_expected.Rds")

# when
result <- sut$compute(
  disease_rna_seq,
  "000000000000000000001111111111111111111",
  absolute_package_directory("test/connectivity_score/drug_dge/"),
  drugs,
  drug_genes,
  "t.value_6h",
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
test_that("test-DichotomicVoomDrugRepurpose", {
  expect_equal(result, expected)
}
)
