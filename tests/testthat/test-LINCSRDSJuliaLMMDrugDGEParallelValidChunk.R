library(testthat)

# setup
sut <- LINCSRDSJuliaLMMDrugDGEParallel$new(
  "",
  ""
)

# given
chunk1 <- list()
chunk1$perturbation_times <- NA
chunk1$gene_list <- c("140", "780")
chunk1$drugs_filter <- c("AM-92016", "AMG-9810", "AMN-082")
chunk1$number <- 1

chunks <- list()
chunks[[1]] <- chunk1

# when

result1 <- tryCatch({
  sut$process(chunks)
}, error = function(e) {
  "error"
})

chunk1$perturbation_times <- "24"
chunk1$gene_list <- NA
result2 <- tryCatch({
  sut$process(chunks)
}, error = function(e) {
  "error"
})

chunk1$gene_list <- "aa"
chunk1$number <- "dd"
result3 <- tryCatch({
  sut$process(chunks)
}, error = function(e) {
  "error"
})


chunk1$number <- 0
result4 <- tryCatch({
  sut$process(chunks)
}, error = function(e) {
  "error"
})

chunk1$number <- NA
result5 <- tryCatch({
  sut$process(chunks)
}, error = function(e) {
  "error"
})

# then
test_that("test-LINCSRDSJuliaLMMDrugDGEParallelValidChunk", {
  expect_equal(result1, "error")
  expect_identical(result2, "error")
  expect_identical(result3, "error")
  expect_identical(result4, "error")
  expect_identical(result5, "error")
}
)
