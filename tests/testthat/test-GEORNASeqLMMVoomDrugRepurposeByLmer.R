library(testthat)

# setup
geoRNASeqLMMMetadataLoader <- GEORNASeqLMMMetadataLoader$new()
drugSignatureLoaderByDrugName <- DrugSignatureLoaderByDrugName$new(absolute_path_directory("unit_test_data/connectivity_score/drug_dge/"), "t.value_6h")
sut <- GEORNASeqLMMVoomDrugRepurpose$new(geoRNASeqLMMVoomDGE = GEORNASeqLMMVoomDGELmer$new(), drugSignatureLoader = drugSignatureLoaderByDrugName)

# given
rna_seq_metadata_filename <- absolute_path_filename("unit_test_data/voom/gse153960_metadata.csv")
rna_seq_data_filename <- absolute_path_filename("unit_test_data/voom/GSE153960_raw_counts_GRCh38.p13_NCBI_first_50.tsv")
tissue_statuses_to_be_tested <- c("Non-Neurological Control", "ALS Spectrum MND")
tissue_statuses_map <- c("Control", "als")
formula <- ~tissue_status + (1 | tissue)

drugs_vector <- c("A-23187", "A-443644", "AG-490", "AG-494",
                  "AG-957", "AKT-inhibitor-1-2", "AM-404")
drug_signatures <- data.frame(name = drugs_vector, signature_reference = drugs_vector)

drug_genes <- package_readRDS("extdata/LINCS_gene_info.Rds")
drug_genes <- subset(drug_genes, drug_genes$is_best_inferred_gene == 1)
drug_genes <- drug_genes$gene_id
sample_status_column_name <- "tissue_status"
sample_id_field_name <- "accession"
additional_columns <- "tissue"
random_effect_column_names <- additional_columns

rna_seq_metadata <- geoRNASeqLMMMetadataLoader$load(rna_seq_metadata_filename, sample_status_column_name, tissue_statuses_to_be_tested, tissue_statuses_map, sample_id_field_name, additional_columns)

expected <- absolute_path_readRDS("unit_test_data/drug_repurpose/GEORNASeqLMMVoomDrugRepurpose_expected.Rds")

# when
result <- sut$compute(
  rna_seq_data_filename,
  rna_seq_metadata,
  formula,
  drug_signatures,
  drug_genes,
  10,
  random_effect_column_names,
  sample_status_column_name,
  "ipf",
  "6h",
  F,
  T,
  4
)

# then
result$p.value <- NULL
result$adj.p.value <- NULL
test_that("test-GEORNASeqLMMVoomDrugRepurposeByLmer", {
  expect_equal(result, expected)
}
)
