library(testthat)

# setup
meanThresholdGeneFilter <- MeanThresholdGeneFilter$new(threshold = 10)
drugSignatureLoaderByDrugName <- DrugSignatureLoaderByDrugName$new(absolute_package_directory("unit_test_data/connectivity_score/drug_dge/"), "t.value_6h")
sut <- DichotomicDrugRepurpose$new(geneFilter = meanThresholdGeneFilter, drugSignatureLoader = drugSignatureLoaderByDrugName)

# given
drugs_vector <- c("A-23187", "A-443644", "AG-490", "AG-494",
                  "AG-957", "AKT-inhibitor-1-2", "AM-404")
drugs <- data.frame(name = drugs_vector, filename = drugs_vector)

drug_genes <- package_readRDS("extdata/LINCS_gene_info.Rds")
drug_genes <- subset(drug_genes, drug_genes$is_best_inferred_gene == 1)
drug_genes <- drug_genes$gene_id
disease_rna_seq_filename <- absolute_path_filename("unit_test_data/voom/GSE92592_raw_counts_GRCh38.p13_NCBI.tsv.gz")
disease_rna_seq <- as.matrix(data.table::fread(disease_rna_seq_filename, header = T, colClasses = "integer"), rownames = "GeneID")
pseudo_disease_rna_data <- log2(disease_rna_seq + 1)
expected <- absolute_path_readRDS("unit_test_data/drug_repurpose/DichotomicDrugRepurpose_expected.Rds")

# when
result <- sut$compute(
  rna_data = pseudo_disease_rna_data,
  sample_01_map = "111111111111111111110000000000000000000",
  drugs,
  drug_genes,
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
test_that("test-DichotomicDrugRepurpose", {
  expect_equal(result, expected)
}
)
