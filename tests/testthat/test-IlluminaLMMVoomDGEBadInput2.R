library(testthat)

# setup
lmmVoomDreamDGE <- LMMVoomDreamDGE$new()
sut <- IlluminaLMMVoomDGE$new(lmmVoomDreamDGE)

# given
tissue_statuses_to_be_tested <- c("Non-Neurological Control", "ALS Spectrum MND")
tissue_statuses_map <- c("Control", "als", "other")

# when
result <- tryCatch({
  sut$compute(
    rna_seq_data_filename = NA,
    rna_seq_metadata_filename = NA,
    formula = NA,
    tissue_status_field_name = NA,
    tissue_statuses_to_be_tested = tissue_statuses_to_be_tested,
    tissue_statuses_map = tissue_statuses_map,
    sample_id_field_name = NA,
    additional_fields = NA,
    filter_by_protein_coding = F
  )
}, error = function(e) {
  "error"
})

# then
test_that("test-IlluminaLMMVoomDGEBadInput2", {
  expect_identical(result, "error")
}
)
