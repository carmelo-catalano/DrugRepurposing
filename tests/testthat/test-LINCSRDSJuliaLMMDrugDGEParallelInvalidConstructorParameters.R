library(testthat)

# when
result1 <- tryCatch({
  sut <- LINCSRDSJuliaLMMDrugDGEParallel$new(
    NA,  "",  0
  )
}, error = function(e) {
  "error"
})

result2 <- tryCatch({
  sut <- LINCSRDSJuliaLMMDrugDGEParallel$new(
    "",  NULL,  0
  )
}, error = function(e) {
  "error"
})

result3 <- tryCatch({
  sut <- LINCSRDSJuliaLMMDrugDGEParallel$new(
    "",  "",  -1
  )
}, error = function(e) {
  "error"
})

result4 <- tryCatch({
  sut <- LINCSRDSJuliaLMMDrugDGEParallel$new(
    "",  "",  1,  0
  )
}, error = function(e) {
  "error"
})

result5 <- tryCatch({
  sut <- LINCSRDSJuliaLMMDrugDGEParallel$new(
    "",  "",  0,  1,  "regerg"
  )
}, error = function(e) {
  "error"
})

# then
test_that("test-LINCSRDSJuliaLMMDrugDGEParallelInvalidConstructorParameters", {
  expect_identical(result1, "error")
  expect_identical(result2, "error")
  expect_identical(result3, "error")
  expect_identical(result4, "error")
  expect_identical(result5, "error")
}
)
