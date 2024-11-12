#' Create a linelist from a data.frame
#'
#' This function converts a `data.frame` or a `tibble` into a `linelist` object,
#' where different types of epidemiologically relevant data are labelled. This
#' includes dates of different events (e.g. onset of symptoms, case reporting),
#' information on the patient (e.g. age, gender, location) as well as other
#' information such as the type of case (e.g. confirmed, probable) or the
#' outcome of the disease. The output will seem to be the same `data.frame`,
#' but `linelist`-aware packages will then be able to automatically use tagged
#' fields for further data cleaning and analysis.
#'
#' @param x a `data.frame` or a `tibble` containing case line list data, with
#'   cases in rows and variables in columns
#'
#' @param ... <[`dynamic-dots`][rlang::dyn-dots]> A series of labels provided as
#'   `column_name = "label"`, where `column_name` indicates any of the known
#'   variables listed in 'Details' and values indicate their name in `x`.
#'
#' @param strict a `logical` indicating whether all labels are required
#'   (`TRUE`) or whether provided labels are matched to the those present in
#'   `x` (`FALSE`). If `TRUE` labelled but missing variables will result in
#'   errors.
#'
#' @param allow_extra a `logical` indicating if additional labels not
#'   currently recognized by `linelist` should be allowed; if `FALSE`, unknown
#'   labels will trigger an error
#'
#' @seealso
#'
#' * An overview of the [linelist] package
#' * [vars_types()]: for the associated accepted types/classes
#' * [labels()]: for a list of tagged variables in a `linelist`
#' * [set_labels()]: for modifying tags
#' * [labels_df()]: for selecting variables by tags
#'
#' @details `make_linelist` defaults to permissive parameters. That is, it
#' will be non-strict and allow extra labels by default.
#'
#' You can easily change default variables using [update_defaults()] and
#' passing the returned object using the `!!!` splice operator.
#'
#' Default variables and their types include:
#'
#' * `id`: a unique case identifier as `numeric` or `character`
#'
#' * `date_onset`: date of symptom onset (see below for date formats)
#'
#' * `date_reporting`: date of case notification (see below for date formats)
#'
#' * `date_admission`: date of hospital admission (see below for date formats)
#'
#' * `date_discharge`: date of hospital discharge (see below for date formats)
#'
#' * `date_outcome`: date of disease outcome (see below for date formats)
#'
#' * `date_death`: date of death (see below for date formats)
#'
#' * `gender`: a `factor` or `character` indicating the gender of the patient
#'
#' * `age`: a `numeric` indicating the age of the patient, in years
#'
#' * `location`: a `factor` or `character` indicating the location of the
#' patient
#'
#' * `occupation`: a `factor` or `character` indicating the professional
#' activity of the patient
#'
#' * `hcw`: a `logical` indicating if the patient is a health care worker
#'
#' * `outcome`: a `factor` or `character` indicating the outcome of the disease
#' (death or survival)
#'
#' Dates can be provided in the following formats/types:
#'
#' * `Date` objects (e.g. using `as.Date` on a `character` with a correct date
#' format); this is the recommended format
#'
#' * `POSIXct/POSIXlt` objects (when a finer scale than days is needed)
#'
#' * `numeric` values, typically indicating the number of days since the first
#' case
#'
#' @export
#'
#' @return The function returns a `linelist` object.
#'
#' @examples
#'
#' if (require(outbreaks)) {
#'   ## dataset we will convert to linelist
#'   head(measles_hagelloch_1861)
#'
#'   ## create linelist
#'   x <- make_linelist(
#'     measles_hagelloch_1861,
#'     !!!update_defaults(id = "case_ID", date_onset = "date_of_prodrome")
#'   )
#'
#'   ## print result - just first few entries
#'   head(x)
#'
#'   ## check labels
#'   labels(x)
#'
#'   ## you can also add non-standard labels
#'   x <- make_linelist(
#'     measles_hagelloch_1861,
#'     !!!c(
#'       update_defaults(id = "case_ID", date_onset = "date_of_prodrome"),
#'       infector = "Disease infector"
#'     )
#'   )
#' }
#'
make_linelist <- function(x,
                          ...,
                          strict = FALSE,
                          allow_extra = TRUE) {
  # assert inputs
  checkmate::assert_data_frame(x, min.cols = 1)
  checkmate::assert_logical(strict)
  checkmate::assert_logical(allow_extra)

  args <- rlang::list2(...)

  # We replace default values with user-provided ones, and then
  # tag each variable in turn. Validation the tagged variables is done
  # elsewhere.
  lbl <- modify_defaults(label_defaults(),
    args,
    allow_extra = allow_extra
  )
  # Retain only those lbl list values whose name is present in x if !strict
  if (!strict) lbl <- lbl[names(lbl) %in% names(x)]

  x <- safeframe::make_safeframe(x, !!!lbl)

  # shape output and return object
  class(x) <- c("linelist", class(x))
  x
}
