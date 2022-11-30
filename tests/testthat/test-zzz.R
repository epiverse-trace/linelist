test_that("tests for zzz", {
  # We need to use callr to avoid conflicts with other tests
  res <- callr::r(
    function() {
      library(linelist)
      get_lost_tags_action()
    }
  )
  expect_identical(res, "warning")
})
