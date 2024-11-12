test_that("modify_defaults successfully updates defaults with matching elements from x", {
  defaults <- list(a = "Healthcare worker", b = "Date of symptom onset")
  x <- list(hcw = "Healthcare worker", date_onset = "Date of symptom onset")
  result <- modify_defaults(defaults, x, allow_extra = TRUE)

  expect_equal(result, x)
})

test_that("modify_defaults successfully updates with extras", {
  defaults <- list(a = "Healthcare worker", b = "Date of symptom onset")
  x <- list(
    hcw = "Healthcare worker",
    date_onset = "Date of symptom onset",
    date_reporting = "Date of reporting to health authorities"
  )
  result <- modify_defaults(defaults, x, allow_extra = TRUE)
  expect_equal(result, x)
})

# Test for expected failure
test_that("modify_defaults throws an error when allow_extra is FALSE and x has extra elements", {
  defaults <- list(a = "Healthcare worker", b = "Date of symptom onset")
  x <- list(
    hcw = "Healthcare worker",
    date_onset = "Date of symptom onset",
    date_reporting = "Date of reporting to health authorities"
  )

  expect_error(
    modify_defaults(defaults, x),
    "There are labels in x that are not defaults and allow_extra is FALSE"
  )
})

test_that("modify_defaults throws an error when x
          has duplicate labels", {
  defaults <- list(a = "Healthcare worker", b = "Date of symptom onset")
  x <- list(
    hcw = "Healthcare worker",
    d = "Healthcare worker",
    date_onset = "Date of symptom onset",
    date_reporting = "Date of reporting to health authorities"
  )

  expect_error(
    modify_defaults(defaults, x, allow_extra = TRUE),
    "Assertion on 'x' failed: Contains duplicated values, position 2."
  )
})
