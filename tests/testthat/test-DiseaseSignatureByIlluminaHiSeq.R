library(testthat)

Sys.setlocale(locale = "C")

# setup
genefilter <- LogarithmGeneFilter$new()
sut <- DiseaseSignatureByIlluminaHiSeq$new(genefilter)

# given
disease_name <- "ipf"
disease_rna_seq_filename <- absolute_package_filename("test/disease_signature/GSE92592_raw_counts_GRCh38.p13_NCBI.tsv")
disease_rna_seq_samples_groups_map <- "000000000000000000001111111111111111111"

expected <- package_readRDS("test/disease_signature/DiseaseSignatureByIlluminaHiSeq_expected.Rds")

# when
result <- sut$compute(disease_rna_seq_filename, disease_rna_seq_samples_groups_map, disease_name, F)
result$p.value <- NULL
result$adj.p.value <- NULL

# then
test_that("test-DiseaseSignatureByIlluminaHiSeq", {
  expect_equal(result, expected)
}
)
