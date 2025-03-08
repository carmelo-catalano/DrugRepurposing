library(testthat)

# setup
sut <- DGEMetanalysisByRow$new()

# given
drug_by_gene_dge_6h <- package_readRDS("test/LMMDGE/metanalysis/drug_dge_6h.Rds")
drug_by_gene_dge_24h <- package_readRDS("test/LMMDGE/metanalysis/drug_dge_24h.Rds")
drug_by_gene_dge_6h_24h <- merge(x = drug_by_gene_dge_6h, y = drug_by_gene_dge_24h, by = c("gene_id", "drug"))
colnames(drug_by_gene_dge_6h_24h)[3:5] <- c("DE_log2_FC_A", "std.error_A", "t.value_A")
colnames(drug_by_gene_dge_6h_24h)[6:8] <- c("DE_log2_FC_B", "std.error_B", "t.value_B")
expected <- package_readRDS("test/LMMDGE/metanalysis/DGEMetanalysis_expected.Rds")

# when
result <- sut$compute(drug_by_gene_dge_6h_24h[1,])

# then
test_that("test-DGEMetanalysisByRow", {
  expect_equal(result, expected)
}
)