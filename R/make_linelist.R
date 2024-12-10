#' Create a linelist from a data.frame
#'
#' This function converts a `data.frame` or a `tibble` into a `linelist` object,
#' where different types of epidemiologically relevant data are tagged. This
#' includes dates of different events (e.g. onset of symptoms, case reporting),
#' information on the patient (e.g. age, gender, location) as well as other
#' information such as the type of case (e.g. confirmed, probable) or the
#' outcome of the disease. The output will seem to be the same `data.frame`, but
#' `linelist`-aware packages will then be able to automatically use tagged
#' fields for further data cleaning and analysis.
#'
#' @param x a `data.frame` or a `tibble` containing case line list data, with
#'   cases in rows and variables in columns
#'
#' @param ... <[`dynamic-dots`][rlang::dyn-dots]> A series of tags provided as
#'   `tag_name = "column_name"`, where `tag_name` indicates any of the known
#'   variables listed in 'Details' and values indicate their name in `x`; see
#'   details for a list of known variable types and their expected content
#'
#' @param allow_extra a `logical` indicating if additional data tags not
#'   currently recognized by `linelist` should be allowed; if `FALSE`, unknown
#'   tags will trigger an error
#'
#' @seealso
#'
#' * An overview of the [linelist] package
#' * [tags_names()]: for a list of known tag names
#' * [tags_types()]: for the associated accepted types/classes
#' * [tags()]: for a list of tagged variables in a `linelist`
#' * [set_tags()]: for modifying tags
#' * [tags_df()]: for selecting variables by tags
#'
#' @details Known variable types include:
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
#'
#'   ## dataset we will convert to linelist
#'   head(measles_hagelloch_1861)
#'
#'   ## create linelist
#'   x <- make_linelist(measles_hagelloch_1861,
#'     id = "case_ID",
#'     date_onset = "date_of_prodrome",
#'     age = "age",
#'     gender = "gender"
#'   )
#'
#'   ## print result - just first few entries
#'   head(x)
#'
#'   ## check tags
#'   tags(x)
#'
#'   ## Tags can also be passed as a list with the splice operator (!!!)
#'   my_tags <- list(
#'     id = "case_ID",
#'     date_onset = "date_of_prodrome",
#'     age = "age",
#'     gender = "gender"
#'   )
#'   new_x <- make_linelist(measles_hagelloch_1861, !!!my_tags)
#'
#'   ## The output is strictly equivalent to the previous one
#'   identical(x, new_x)
#' }
#'
make_linelist <- function(x,
                          ...,
                          allow_extra = FALSE) {
  # assert inputs
  checkmate::assert_data_frame(x, min.cols = 1)
  assert_not_data_table(x)
  checkmate::assert_logical(allow_extra)

  args <- rlang::list2(...)

  # The approach is to replace default values with user-provided ones, and then
  # tag each variable in turn. Validation the tagged variables is done
  # elsewhere.
  tags <- tags_defaults()

  tags <- modify_defaults(tags, args, strict = !allow_extra)

  x <- tag_variables(x, tags)

  # shape output and return object
  class(x) <- c("linelist", class(x))
  x
}
