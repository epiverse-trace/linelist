#' Update default column names for labelling
#'
#' A function to update default column names for labelling.
#'
#' @param id default column name to replace, using `id = "new_id"`
#'
#' @param date_onset default column name to replace, using date_ons`date_onset = "new_date_onset"`
#'
#' @param date_reporting default column name to replace, using date_reporti`date_reporting = "new_date_reporting"`
#'
#' @param date_admission default column name to replace, using date_admissi`date_admission = "new_date_admission"`
#'
#' @param date_discharge default column name to replace, using date_dischar`date_discharge = "new_date_discharge"`
#'
#' @param date_outcome default column name to replace, using date_outco`date_outcome = "new_date_outcome"`
#'
#' @param date_death default column name to replace, using date_dea`date_death = "new_date_death"`
#'
#' @param gender default column name to replace, using gend`gender = "new_gender"`
#'
#' @param age default column name to replace, using a`age = "new_age"`
#'
#' @param location default column name to replace, using locati`location = "new_location"`
#'
#' @param occupation default column name to replace, using occupati`occupation = "new_occupation"`
#'
#' @param hcw default column name to replace, using h`hcw = "new_hcw"`
#'
#' @param outcome default column name to replace, using outco`outcome = "new_outcome"`
#'
#' @details
#'
#' You can use this function to update one, all, or any variation of column
#' names. If run without arguments, it returns the same as `label_defaults()`.
#'
#' @example
#'
#' @export
#'
#' @return A named `list`.

update_defaults <- function(
    id = "id",
    date_onset = "date_onset",
    date_reporting = "date_reporting",
    date_admission = "date_admission",
    date_discharge = "date_discharge",
    date_outcome = "date_outcome",
    date_death = "date_death",
    gender = "gender",
    age = "age",
    location = "location",
    occupation = "occupation",
    hcw = "hcw",
    outcome = "outcome") {
  defaults <- label_defaults()

  names(defaults) <- c(
    id,
    date_onset,
    date_reporting,
    date_admission,
    date_discharge,
    date_outcome,
    date_death,
    gender,
    age,
    location,
    occupation,
    hcw,
    outcome
  )

  invisible(defaults)
}
