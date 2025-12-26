library(testthat)

# setup
drugSignatureLoaderByDrugName <- DrugSignatureLoaderByDrugName$new(absolute_package_directory("test/connectivity_score/drug_dge/"), "t.value_6h")
sut <- DichotomicVoomDrugRepurpose$new(drugSignatureLoader = drugSignatureLoaderByDrugName)

# given
drugs_vector <- c("A-23187", "A-443644", "AG-490", "AG-494",
                  "AG-957", "AKT-inhibitor-1-2", "AM-404")
drugs <- data.frame(name = drugs_vector, filename = drugs_vector)

drugs_genes <- package_readRDS("extdata/LINCS_gene_info.Rds")
drugs_genes <- subset(drugs_genes, drugs_genes$is_best_inferred_gene == 1)
drugs_genes <- drugs_genes$gene_id
disease_rna_seq_filename <- absolute_package_filename("test/voom/GSE92592_raw_counts_GRCh38.p13_NCBI.tsv.gz")
disease_rna_seq <- as.matrix(data.table::fread(disease_rna_seq_filename, header = T, colClasses = "integer"), rownames = "GeneID")

expected <- package_readRDS("test/drug_repurpose/DichotomicVoomDrugRepurpose_expected.Rds")

# when
result <- sut$compute(
  rna_seq = disease_rna_seq,
  sample_01_map = "000000000000000000001111111111111111111",
  drugs = drugs,
  drugs_genes = drugs_genes,
  random_distribution_size = 10,
  disease_name = "ipf",
  drug_perturbation_time = "6h",
  filter_by_protein_coding = F,
  parallel_computation = F,
  signature_mapper_parameter = 100
)

# then
result$p.value <- NULL
result$adj.p.value <- NULL
test_that("test-DichotomicVoomDrugRepurpose", {
  expect_equal(result, expected)
}
)
