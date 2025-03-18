library(testthat)

# setup
drug_dge_dir <- absolute_package_directory("test/connectivity_score/drug_dge/")
drug_gde_t_value_column_name <- "t.value_6h"
drugSignatureLoaderByDrugName <- DrugSignatureLoaderByDrugName$new(drug_dge_dir, drug_gde_t_value_column_name)
sut <- LMMDrugRepurpose$new(lmmDGE = LMMDGEJulia$new(), drugSignatureLoader = drugSignatureLoaderByDrugName)

# given
rna_seq_metadata_filename <- absolute_package_filename("test/voom/gse153960_metadata.csv")
rna_seq_data_filename <- absolute_package_filename("test/voom/GSE153960_raw_counts_GRCh38.p13_NCBI_first_50.tsv")
tissue_statuses_to_be_tested <- c("Non-Neurological Control", "ALS Spectrum MND")
tissue_statuses_map <- c("Control", "als")
formula <- ~tissue_status + (1 | tissue)
tissue_status_field_name <- "tissue_status"
sample_id_field_name <- "accession"
additional_fields <- "tissue"

geoRNASeqLMMLoader <- GEORNASeqLMMLoader$new()
rna_seq <- geoRNASeqLMMLoader$load(rna_seq_data_filename, rna_seq_metadata_filename, tissue_status_field_name, tissue_statuses_to_be_tested, tissue_statuses_map, sample_id_field_name = "accession", additional_fields = "tissue")
rna_seq$data <- log2(rna_seq$data + 1)

drugs_vector <- c("A-23187", "A-443644", "AG-490", "AG-494",
                  "AG-957", "AKT-inhibitor-1-2", "AM-404")
drugs <- data.frame(name = drugs_vector, filename = drugs_vector)

drug_genes <- package_readRDS("extdata/LINCS_gene_info.Rds")
drug_genes <- subset(drug_genes, drug_genes$is_best_inferred_gene == 1)
drug_genes <- drug_genes$gene_id
expected <- package_readRDS("test/drug_repurpose/LMMDrugRepurpose_expected.Rds")

# when
result <- sut$compute(
  rna_seq$data,
  rna_seq$metadata,
  formula,
  "ipf",
  5,
  drugs,
  drug_genes,
  10,
  "6h",
  F,
  F
)

# then
result$p.value <- NULL
result$adj.p.value <- NULL
test_that("test-LMMDrugRepurposeByJulia", {
  expect_equal(result, expected)
}
)
