
<!-- README.md is generated from README.Rmd. Please edit that file -->

# *linelist*: Tagging and Validating Epidemiological Data <img src="man/figures/logo.svg" align="right" width="120" />

<!-- badges: start -->

[![Digital Public
Good](https://raw.githubusercontent.com/epiverse-trace/linelist/main/man/figures/dpg_badge.png)](https://digitalpublicgoods.net/registry/linelist.html)
[![License:
MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![cran-check](https://badges.cranchecks.info/summary/linelist.svg)](https://cran.r-project.org/web/checks/check_results_linelist.html)
[![R-CMD-check](https://github.com/epiverse-trace/linelist/workflows/R-CMD-check/badge.svg)](https://github.com/epiverse-trace/linelist/actions)
[![codecov](https://codecov.io/gh/epiverse-trace/linelist/branch/main/graph/badge.svg?token=JGTCEY0W02)](https://codecov.io/gh/epiverse-trace/linelist)
[![lifecycle-experimental](https://raw.githubusercontent.com/reconverse/reconverse.github.io/master/images/badge-experimental.svg)](https://www.reconverse.org/lifecycle.html#experimental)
[![month-download](https://cranlogs.r-pkg.org/badges/linelist)](https://cran.r-project.org/package=linelist)
[![total-download](https://cranlogs.r-pkg.org/badges/grand-total/linelist)](https://cran.r-project.org/package=linelist)
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.6556047.svg)](https://doi.org/10.5281/zenodo.6556047)

<!-- badges: end -->

*linelist* provides a safe entry point to the *Epiverse* software
ecosystem, adding a foundational layer through *tagging*, *validation*,
and *safeguarding* epidemiological data, to help make data pipelines
more straightforward and robust.

## Installation

### Stable version

Our stable versions are released on CRAN, and can be installed using:

``` r
install.packages("linelist", build_vignettes = TRUE)
```

### Development version

The development version of *linelist* can be installed from
[GitHub](https://github.com/) with:

``` r
if (!require(remotes)) {
  install.packages("remotes")
}
remotes::install_github("epiverse-trace/linelist", build_vignettes = TRUE)
```

## Usage

<img src="man/figures/linelist_infographics.png" width="60%" />

*linelist* works by tagging key epidemiological data in a `data.frame`
or a `tibble` to facilitate and strengthen data pipelines. The resulting
object is a `linelist` object, which extends `data.frame` (or `tibble`)
by providing three types of features:

1.  a **tagging system** to identify key data, enabling access to these
    data using their tags rather than actual names, which may change
    over time and across datasets

2.  **validation** of the tagged variables (making sure they are present
    and of the right type/class)

3.  **safeguards** against accidental losses of tagged variables in
    common data handling operations

The short example below illustrates these different features. See the
[Documentation](#Documentation) section for more in-depth examples and
details about `linelist` objects.

``` r

# load packages and a dataset for the example
# -------------------------------------------
library(pacman)
#> Error in library(pacman): there is no package called 'pacman'
p_load(dplyr)
#> Error in p_load(dplyr): could not find function "p_load"
p_load(magrittr)
#> Error in p_load(magrittr): could not find function "p_load"
p_load(outbreaks)
#> Error in p_load(outbreaks): could not find function "p_load"
p_load(incidence2)
#> Error in p_load(incidence2): could not find function "p_load"
p_load(linelist)
#> Error in p_load(linelist): could not find function "p_load"

dataset <- outbreaks::mers_korea_2015$linelist
head(dataset)
#>     id age age_class sex        place_infect reporting_ctry
#> 1 SK_1  68     60-69   M         Middle East    South Korea
#> 2 SK_2  63     60-69   F Outside Middle East    South Korea
#> 3 SK_3  76     70-79   M Outside Middle East    South Korea
#> 4 SK_4  46     40-49   F Outside Middle East    South Korea
#> 5 SK_5  50     50-59   M Outside Middle East    South Korea
#> 6 SK_6  71     70-79   M Outside Middle East    South Korea
#>                                              loc_hosp   dt_onset  dt_report
#> 1 Pyeongtaek St. Mary, Hospital, Pyeongtaek, Gyeonggi 2015-05-11 2015-05-19
#> 2 Pyeongtaek St. Mary, Hospital, Pyeongtaek, Gyeonggi 2015-05-18 2015-05-20
#> 3 Pyeongtaek St. Mary, Hospital, Pyeongtaek, Gyeonggi 2015-05-20 2015-05-20
#> 4 Pyeongtaek St. Mary, Hospital, Pyeongtaek, Gyeonggi 2015-05-25 2015-05-26
#> 5                           365 Yeollin Clinic, Seoul 2015-05-25 2015-05-27
#> 6 Pyeongtaek St. Mary, Hospital, Pyeongtaek, Gyeonggi 2015-05-24 2015-05-28
#>   week_report dt_start_exp dt_end_exp    dt_diag outcome   dt_death
#> 1     2015_21   2015-04-18 2015-05-04 2015-05-20   Alive       <NA>
#> 2     2015_21   2015-05-15 2015-05-20 2015-05-20   Alive       <NA>
#> 3     2015_21   2015-05-16 2015-05-16 2015-05-21    Dead 2015-06-04
#> 4     2015_22   2015-05-16 2015-05-20 2015-05-26   Alive       <NA>
#> 5     2015_22   2015-05-17 2015-05-17 2015-05-26   Alive       <NA>
#> 6     2015_22   2015-05-15 2015-05-17 2015-05-28    Dead 2015-06-01

# check known tagged variables
# ----------------------------
tags_names()
#> Error in tags_names(): could not find function "tags_names"

# build a linelist
# ----------------
x <- dataset %>%
  tibble() %>%
  make_linelist(date_onset = "dt_onset", # date of onset
                date_reporting = "dt_report", # date of reporting
                occupation = "age" # mistake
                )
#> Error in dataset %>% tibble() %>% make_linelist(date_onset = "dt_onset", : could not find function "%>%"
x
#> Error in eval(expr, envir, enclos): object 'x' not found
tags(x) # check available tags
#> Error in tags(x): could not find function "tags"

# validation of tagged variables
# ------------------------------
## (this flags a likely mistake: occupation should not be an integer)
validate_linelist(x)
#> Error in validate_linelist(x): could not find function "validate_linelist"

# change tags: fix mistakes, add new ones
# ---------------------------------------
x <- x %>%
  set_tags(occupation = NULL, # tag removal
           gender = "sex", # new tag
           outcome = "outcome"
           )
#> Error in x %>% set_tags(occupation = NULL, gender = "sex", outcome = "outcome"): could not find function "%>%"

# safeguards against actions losing tags
# --------------------------------------
## attemping to remove geographical info but removing dates by mistake
x_no_geo <- x %>%
  select(-(5:8))
#> Error in x %>% select(-(5:8)): could not find function "%>%"

## for stronger pipelines, trigger errors upon loss
x_no_geo <- x %>%
  lost_tags_action("error") %>% 
  select(-(5:8))
#> Error in x %>% lost_tags_action("error") %>% select(-(5:8)): could not find function "%>%"

x_no_geo <- x %>%
  select(-(5:7))
#> Error in x %>% select(-(5:7)): could not find function "%>%"

## to revert to default behaviour (warning upon error)
lost_tags_action()
#> Error in lost_tags_action(): could not find function "lost_tags_action"

# access content by tags, and build downstream pipelines
# ------------------------------------------------------
x_no_geo %>%
  select_tags(date_onset, outcome)
#> Error in x_no_geo %>% select_tags(date_onset, outcome): could not find function "%>%"

x_no_geo %>%
  tags_df()
#> Error in x_no_geo %>% tags_df(): could not find function "%>%"

x_no_geo %>%
  tags_df() %>%
  incidence("date_onset", groups = c("gender", "outcome")) %>%
  facet_plot(facets = "gender", fill = outcome)
#> Error in x_no_geo %>% tags_df() %>% incidence("date_onset", groups = c("gender", : could not find function "%>%"
```

## Documentation

More detailed documentation can be found at:
<https://epiverse-trace.github.io/linelist/>

In particular:

- A general introduction to *linelist*
  ([link](https://epiverse-trace.github.io/linelist/articles/linelist.html))

- The reference manual
  ([link](https://epiverse-trace.github.io/linelist/reference/index.html))

## Getting help

To ask questions or give us some feedback, please use the github
[issues](https://github.com/epiverse-trace/linelist/issues) system.

## Data privacy

Case line lists may contain personally identifiable information (PII).
While *linelist* provides a way to store this data in R, it does not
currently provide tools for data anonymization. The user is responsible
for respecting individual privacy and ensuring PII is handled with the
required level of confidentiality, in compliance with applicable laws
and regulations for storing and sharing PII.

Note that PII is rarely needed for common analytics tasks, so that in
many instances it may be advisable to remove PII from the data before
sharing them with analytics teams.

## Development

### Lifecycle

This package is currently *experimental*, as defined by the [RECON
software lifecycle](https://www.reconverse.org/lifecycle.html). This
means that essential features and mechanisms should not change
drastically, but depending on user feedback, functions may be renamed,
arguments may change, some functionalities may be added, etc.

### Contributions

Contributions are welcome via [pull
requests](https://github.com/epiverse-trace/linelist/pulls).

Contributors to the project include:

- Thibaut Jombart (author)
- David Mascarina (logo)
- Emma Marty (communication)
- Pietro Monticone (contributor)

### Code of Conduct

Please note that the linelist project is released with a [Code of
Conduct](https://github.com/epiverse-trace/.github/blob/main/CODE_OF_CONDUCT.md).
By contributing to this project, you agree to abide by its terms.

### Notes

This package is a reboot of the RECON package
[linelist](https://github.com/reconhub/linelist). Unlike its
predecessor, the new package focuses on the implementation of a
*linelist* class. The data cleaning features of the original package
will eventually be re-implemented for *linelist* objects, albeit likely
in a separate package.
