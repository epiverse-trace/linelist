
<!-- README.md is generated from README.Rmd. Please edit that file -->

<!-- badges: start -->

[![License:
MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![R-CMD-check](https://github.com/epiverse-trace/linelist/workflows/R-CMD-check/badge.svg)](https://github.com/epiverse-trace/linelist/actions)
[![codecov](https://codecov.io/gh/epiverse-trace/linelist/branch/main/graph/badge.svg?token=JGTCEY0W02)](https://codecov.io/gh/epiverse-trace/linelist)
<!-- badges: end -->

# Welcome to linelist\!

<br> **<span style="color: red;">NOTE</span>**

This package is a reboot of the RECON package
[linelist](https://github.com/reconhub/linelist). Unliked its
predecessor, the new package focuses on the implementation of a linelist
class. It will also eventually implement data cleaning tools,
replicating functionalities of the older package. However, the new
package should be seen as a separate one, and will not aim to be
backward compatible due to its change in scope.

The development version of *linelist* can be installed from
[GitHub](https://github.com/) with:

``` r
if (!require(remotes)) {
  install.packages("remotes")
}
remotes::install_github("epiverse-trace/linelist", build_vignettes = TRUE)
```

## linelist in a nutshell

*linelist* is an R package which implements basic data representation
for case line lists, alongside accessors and basic methods. It relies on
the idea that key fields of the linelist such as dates of events
(e.g. reporting, symptom onset), age, gender, symptoms, outcome, or
location, should be explicitely identified to facilitate data cleaning,
validation, and downstream analyses.

## Contributing guidelines

Contributions are welcome via **pull requests**.

### Code of Conduct

Please note that the linelist project is released with a [Contributor
Code of
Conduct](https://contributor-covenant.org/version/2/0/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.
