library(testthat)

# setup
lmmVoomDreamDGE <- LMMVoomDreamDGE$new()
sut <- IlluminaLMMVoomDGE$new(lmmVoomDreamDGE)

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
test_that("test-IlluminaLMMVoomDGEBadInput", {
  expect_identical(result, "error")
}
)
