library(testthat)

# setup
drug_dge_dir <- absolute_path_directory("unit_test_data/connectivity_score/drug_dge/")
drug_dge_t_value_column_name <- "t.value_6h"
drugSignatureLoaderByDrugName <- DrugSignatureLoaderByDrugName$new(drug_dge_dir, drug_dge_t_value_column_name)
sut <- LMMVoomDrugRepurpose$new(drugSignatureLoader = drugSignatureLoaderByDrugName)

# given
rna_seq_metadata_filename <- absolute_path_filename("unit_test_data/voom/gse153960_metadata.csv")
rna_seq_data_filename <- absolute_path_filename("unit_test_data/voom/GSE153960_raw_counts_GRCh38.p13_NCBI_first_50.tsv")
sample_statuses_to_be_tested <- c("Non-Neurological Control", "ALS Spectrum MND")
sample_statuses_map <- c("Control", "als")
formula <- ~tissue_status + (1 | tissue)
sample_status_column_name <- "tissue_status"
sample_id_column_name <- "accession"
additional_columns <- "tissue"
random_effect_column_names <- additional_columns

geoRNASeqLMMDataMetadataLoader <- GEORNASeqLMMDataMetadataLoader$new()
rna_seq <- geoRNASeqLMMDataMetadataLoader$load(
  rna_seq_data_filename,
  rna_seq_metadata_filename,
  random_effect_column_names,
  sample_status_column_name,
  sample_statuses_to_be_tested,
  sample_statuses_map,
  sample_id_column_name,
  additional_columns
)

drugs_vector <- c("A-23187", "A-443644", "AG-490", "AG-494",
                  "AG-957", "AKT-inhibitor-1-2", "AM-404")
drugs <- data.frame(name = drugs_vector, filename = drugs_vector)

drug_genes <- package_readRDS("extdata/LINCS_gene_info.Rds")
drug_genes <- subset(drug_genes, drug_genes$is_best_inferred_gene == 1)
drug_genes <- drug_genes$gene_id
expected <- absolute_path_readRDS("unit_test_data/drug_repurpose/LMMVoomDrugRepurpose_expected.Rds")

# when
result <- sut$compute(
  rna_seq$data,
  rna_seq$metadata,
  formula,
  drugs,
  drug_genes,
  10,
  "ipf",
  "6h",
  F,
  F,
  5
)

# then
result$p.value <- NULL
result$adj.p.value <- NULL
test_that("test-LMMVoomDrugRepurposeByDream", {
  expect_equal(result, expected)
}
)
