#' Base Tools for Storing and Handling Case Line Lists
#'
#' The *linelist* package provides tools to help storing and handling case line
#' list data. The `linelist` class adds a tagging system to classical
#' `data.frame` or `tibble` objects which permits to identify key
#' epidemiological data such as dates of symptom onset, epi case definition,
#' age, gender or disease outcome. Once tagged, these variables can be
#' seamlessly used in downstream analyses, making data pipelines more robust and
#' reliable.
#'
#' @docType package
#'
#' @name linelist
#'
#' @aliases linelist
#'
#' @author Thibaut Jombart \email{thibaut@@data.org}
#'
#' @section Main functions:
#'
#' * [make_linelist()]: to create `linelist` objects from a
#' `data.frame` or a `tibble`, with the possibility to tag key epi variables
#'
#' * [set_tags()]: to change or add tagged variables in a `linelist`
#'
#' * [tags()]: to get the list of tags of a `linelist`
#'
#' * [tags_df()]: to get a `data.frame` of all tagged variables
#'
#' * [select_tags()]: like [dplyr::select()], but for tagged variables
#'
#' * [lost_tags_action()]: to change the behaviour of actions
#' where tagged variables are lost (e.g. removing columns storing tagged
#' variables) to issue warnings, errors, or do nothing
#'
#' * [get_lost_tags_action()]: to check the current
#' behaviour of actions where tagged variables are lost
#'
#' @section Dedicated methods:
#'
#' Specific methods commonly used to handle `data.frame` are provided for
#'   `linelist` objects, typically to help flag or prevent actions which could
#'   alter or lose tagged variables (and may thus break downstream data
#'   pipelines).
#'
#' * `names() <-` and `rename` (see [rename.linelist()]): will rename tags as needed
#'
#' * `x[...] <-` and `x[[...]] <-` (see [sub_linelist]): will adopt
#' the desire behaviour when tagged variables are lost
#'
#' * `print()`: prints info about the `linelist` in addition to the `data.frame`
#' or `tibble`
#'
#' @examples
#'
#' if (require(outbreaks)) {
#'   # using base R style
#'
#'   ## dataset we'll create a linelist from, only using the first 50 entries
#'   measles_hagelloch_1861[1:50, ]
#'
#'   ## create linelist
#'   x <- make_linelist(measles_hagelloch_1861[1:50, ],
#'     id = "case_ID",
#'     date_onset = "date_of_prodrome",
#'     age = "age",
#'     gender = "gender"
#'   )
#'   x
#'
#'   ## check tagged variables
#'   tags(x)
#'
#'   ## extract tagged variables
#'   select_tags(x, "gender", "age")
#'
#'   ## robust renaming
#'   names(x)[1] <- "identifier"
#'   x
#'
#'   ## example of dropping tags by mistake - default: warning
#'   x[, 2:5]
#'
#'   ## to silence warnings when taggs are dropped
#'   lost_tags_action("none")
#'   x[, 2:5]
#'
#'   ## to trigger errors when taggs are dropped
#'   # lost_tags_action("error")
#'   # x[, 2:5]
#'
#'   ## reset default behaviour
#'   lost_tags_action()
#'
#'
#'   # using tidyverse style
#'
#'   ## example of creating a linelist, adding a new variable, and adding a tag
#'   ## for it
#'
#'   if (require(dplyr) && require(magrittr)) {
#'     x <- measles_hagelloch_1861 %>%
#'       tibble() %>%
#'       make_linelist(
#'         id = "case_ID",
#'         date_onset = "date_of_prodrome",
#'         age = "age",
#'         gender = "gender"
#'       ) %>%
#'       mutate(result = if_else(is.na(date_of_death), "survived", "died")) %>%
#'       set_tags(outcome = "result") %>%
#'       rename(identifier = case_ID)
#'
#'     x
#'
#'     x %>%
#'       tags()
#'
#'     x %>%
#'       select(starts_with("date"))
#'
#'     ## disable warnings on the fly
#'     x %>%
#'       lost_tags_action("none") %>%
#'       select(starts_with("date"))
#'   }
#' }
#'
NULL
