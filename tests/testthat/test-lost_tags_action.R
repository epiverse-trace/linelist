test_that("tests for lost_tags_action", {
  msg <- "Lost tags will now issue a warning."
  expect_message(lost_tags_action(), msg)

  msg <- "Lost tags will now issue an error."
  expect_message(lost_tags_action("error"), msg)

  msg <- "Lost tags will now be ignored."
  expect_message(lost_tags_action("none"), msg)

  lost_tags_action("error", quiet = TRUE)
  expect_identical(get_lost_tags_action(), "error")

  lost_tags_action("none", quiet = TRUE)
  expect_identical(get_lost_tags_action(), "none")

  lost_tags_action("warning", quiet = TRUE)
  expect_identical(get_lost_tags_action(), "warning")
})

test_that("deprecated pipeline option for lost_tags_action()", {

  x <- make_linelist(cars, date_onset = "dist", date_outcome = "speed")
  expect_error(
    lost_tags_action(x),
    "deprecated"
  )
  expect_error(
    lost_tags_action(
      x = "none"
    )
  )

})
