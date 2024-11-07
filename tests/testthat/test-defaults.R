## No fail tests for default_[vars/labels/types] included at this time

test_that("default_vars succeeds as expected", {
  expect_equal(default_vars(), defaults <- c(
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
  ))
  
  expect_equal(
    default_vars(hcw = "Healthcare worker"),
    defaults <- c(
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
      "Healthcare worker",
      "outcome"
    )
  )
  
  expect_equal(
    default_vars("hacw"),
    defaults <- c(
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
      "hacw"
    )
  )
  
  expect_equal(
    default_vars(hcw = "Healthcare worker", "hacw"),
    defaults <- c(
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
      "Healthcare worker",
      "outcome",
      "hacw"
    )
  )
})

test_that("default_labels succeeds as expected", {
  expect_equal(default_labels(),
               c(
                 "Subject ID",
                 "Date of symptom onset",
                 "date_reporting",
                 "Date of hospital admission",
                 "Date of hospital discharge",
                 "Date of case outcome",
                 "Date of death",
                 "Reported gender",
                 "Reported age",
                 "Reported location",
                 "Reported Occupation",
                 "Healthcare Worker",
                 "Case outcome"
               ))
  
  expect_equal(default_labels("Test label"),
               c(
                 "Subject ID",
                 "Date of symptom onset",
                 "date_reporting",
                 "Date of hospital admission",
                 "Date of hospital discharge",
                 "Date of case outcome",
                 "Date of death",
                 "Reported gender",
                 "Reported age",
                 "Reported location",
                 "Reported Occupation",
                 "Healthcare Worker",
                 "Case outcome",
                 "Test label"
               ))
  
  expect_equal(default_labels("Subject ID" = "New Subject ID"),
               c(
                 "New Subject ID",
                 "Date of symptom onset",
                 "date_reporting",
                 "Date of hospital admission",
                 "Date of hospital discharge",
                 "Date of case outcome",
                 "Date of death",
                 "Reported gender",
                 "Reported age",
                 "Reported location",
                 "Reported Occupation",
                 "Healthcare Worker",
                 "Case outcome"
               ))
})

test_that("default_types succeeds as expected", {
  expect_snapshot(default_types())
  
  expect_snapshot(default_types(type('category')))
})
