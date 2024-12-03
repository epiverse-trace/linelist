## No fail tests for default_[vars/labels/types] included at this time

test_that("default_labels succeeds as expected", {
  expect_equal(
    default_labels(),
    c(
      "id",
      "date_onset",
      "date_reporting",
      "date_admission",
      "date_discharge",
      "date_outcome",
      "date_death",
      "gender",
      "age",
      "location",
      "occupation",
      "hcw",
      "outcome"
    )
  )

  expect_equal(
    default_labels("test"),
    c(
      "id",
      "date_onset",
      "date_reporting",
      "date_admission",
      "date_discharge",
      "date_outcome",
      "date_death",
      "gender",
      "age",
      "location",
      "occupation",
      "hcw",
      "outcome",
      "test"
    )
  )

  expect_equal(
    default_labels("id" = "custom_id"),
    c(
      "custom_id",
      "date_onset",
      "date_reporting",
      "date_admission",
      "date_discharge",
      "date_outcome",
      "date_death",
      "gender",
      "age",
      "location",
      "occupation",
      "hcw",
      "outcome"
    )
  )
})

test_that("default_types succeeds as expected", {
  expect_snapshot(default_types())

  expect_snapshot(default_types(type("category")))
})
