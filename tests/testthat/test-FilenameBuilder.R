library(testthat)

# setup
sut <- FilenameBuilder$new()

# when
result <- sut$build("abc_#id_de#f.Rds",123)

# then
test_that("test-FilenameBuilder", {
  expect_identical(result, "abc_123_de#f.Rds")
}
)

# when
result <- sut$build("abc_#id_de#f_#symbol_L.Rds",78901,"ZFYLR")

# then
test_that("test-FilenameBuilder", {
  expect_identical(result, "abc_78901_de#f_ZFYLR_L.Rds")
}
)

# when
result <- sut$build("abc_#id_de#f_#symbol_L.Rds",78901)

# then
test_that("test-FilenameBuilder", {
  expect_identical(result, "abc_78901_de#f_#symbol_L.Rds")
}
)