library(testthat)

# setup
sut <- LMMVoomDreamDrugRepurpose$new()

# given
rna_seq_metadata_filename <- absolute_package_filename("test/voom/gse153960_metadata.csv")
rna_seq_data_filename <- absolute_package_filename("test/voom/GSE153960_raw_counts_GRCh38.p13_NCBI_first_50.tsv")
tissue_statuses_to_be_tested <- c("Non-Neurological Control", "ALS Spectrum MND")
tissue_statuses_map <- c("Control", "als")
formula <- ~tissue_status + (1 | tissue)

illuminaLMMRNASeqLoader <- IlluminaLMMRNASeqLoader$new()
rna_seq <- illuminaLMMRNASeqLoader$load(rna_seq_metadata_filename, rna_seq_data_filename, tissue_statuses_to_be_tested, tissue_statuses_map)

drugs_vector <- c("A-23187", "A-443644", "AG-490", "AG-494",
                  "AG-957", "AKT-inhibitor-1-2", "AM-404")
drugs <- data.frame(name = drugs_vector, filename = drugs_vector)

drug_genes <- package_readRDS("extdata/LINCS_gene_info.Rds")
drug_genes <- subset(drug_genes, drug_genes$is_best_inferred_gene == 1)
drug_genes <- drug_genes$gene_id
expected <- package_readRDS("test/drug_repurpose/LMMVoomDrugRepurpose_expected.Rds")

# when
result <- sut$compute(
  rna_seq$data,
  rna_seq$metadata,
  formula,
  "ipf",
  5,
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
test_that("test-LMMVoomDreamDrugRepurpose", {
  expect_equal(result, expected)
}
)
