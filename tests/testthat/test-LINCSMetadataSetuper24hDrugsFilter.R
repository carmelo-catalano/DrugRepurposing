library(testthat)
Sys.setlocale(locale="C")

# setup
sut <- LINCSMetadataSetuper$new()

# given
selected_pert_time <- "24"
expected <- package_readRDS("test/LMMDGE/LINCSMetadataSetuper24hDrugsFilterExpected.Rds")
drugs <- c("1-phenylbiguanide", "10-hydroxycamptothecin", "7-nitroindazole", "abiraterone",
           "ABT-737", "ABT-751", "afatinib", "AG-14361", "albendazole", "alfacalcidol",
           "altretamine", "alvespimycin", "alvocidib", "AM-251", "AM-404", "AM-580",
           "aminoglutethimide", "aminopurvalanol-a")

# when
result <- sut$setup(selected_pert_time, drugs)

# then
test_that("test-LINCSMetadataSetuper24hDrugsFilter", {
  expect_identical(result, expected)
}
)

