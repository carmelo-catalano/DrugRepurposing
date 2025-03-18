library(testthat)

# setup
lmmVoomDGEDream <- LMMVoomDGEDream$new()
sut <- GEORNASeqLMMVoomDGE$new(lmmVoomDGEDream)

# given
tissue_statuses_to_be_tested <- c("Non-Neurological Control", "ALS Spectrum MND", "Other")

# when
result <- tryCatch({
  sut$compute(
    rna_seq_data_filename = NA,
    rna_seq_metadata_filename = NA,
    formula = NA,
    tissue_status_field_name = NA,
    tissue_statuses_to_be_tested = tissue_statuses_to_be_tested,
    tissue_statuses_map = NA,
    sample_id_field_name = NA,
    additional_fields = NA,
    filter_by_protein_coding = F
  )
}, error = function(e) {
  "error"
})

# then
test_that("test-GEORNASeqLMMVoomDGEBadInput", {
  expect_identical(result, "error")
}
)
