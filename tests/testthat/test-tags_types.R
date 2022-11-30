test_that("tests for tags_types", {

  # Check errors
  msg <- "Use only tags listed in `tags_names()`, or set `allow_extra = TRUE`"
  expect_error(tags_types(toto = "ilestbo"), msg, fixed = TRUE)

  # Check functionality
  x <- tags_types()
  expect_identical(tags_names(), names(x))
  expect_type(x, "list")
  expect_true(all(sapply(x, is.character)))

  x <- tags_types(date_outcome = "Date")
  expect_identical(x$date_outcome, "Date")
  x <- tags_types(date_outcome = "Date", seq = "DNAbin", allow_extra = TRUE)
  expect_identical(x$seq, "DNAbin")
})
