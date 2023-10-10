# linelist 1.0.0

## New features

* Increased compatibility with dplyr is now documented and ensured through
tests of all dplyr verbs on linelist objects as part of our testing & continuous
integration system, as well as a new vignette: 
<https://epiverse-trace.github.io/linelist/articles/compat-dplyr.html> 
(@Bisaloo, #53)

* A new selection helper is provided for tidyverse users, based on the existing
selectors provided by the tidyselect package: `has_tag()` (@Bisaloo, #61). By 
feeding it a character vector of tags to operate on, you can work with dplyr
verbs on specific tagged columns without having to explicitly use the column
names:

  ```r
  x %>%
    dplyr::select(has_tag(c("id", "date_of_onset")))
  ```

## Breaking changes

* It is no longer possible to use `lost_tags_action()` within a pipeline. It 
must now be set as a separate step. This makes the internal code more robust and
clarifies what is part of the pipeline versus a global option (@Bisaloo, #79).

* The `select_tags()` function is now deprecated to ensure we provide just one
clear way to address a given issue and that our "happy path" is clearly
signposted (@Bisaloo, #61). If you were using this function, we now recommend 
using the more explicit two-steps process:

  ```r
  # Deprecated
  x %>%
    select_tags("age")

  # Instead use
  x %>%
    tags_df() %>%
    select(age)
  
  # Or
  x %>%
    select(has_tag("age")) %>%
    tags_df()
  ```

* The custom `select.linelist()` method has been deprecated as providing a 
custom `[.linelist()` is sufficient to ensure compatibility with
`dplyr::select()` default methods, including triggering `lost_tags_action()`
on tag removal (@Bisaloo, #61).
A full deletion of this method is not possible at the moment because we want to
provide a smooth transition for users that relied on the custom `tags` argument
of the `select.linelist()` method. It is now recommend instead to use the new 
`has_tag()` selection helper:

  ```r
  x %>%
    dplyr::select(has_tag(c("id", "date_of_onset")))
    
  # Instead of
  x %>%
    select(tags = c("id", "date_of_onset"))
  ```

* The custom `rename.linelist()` method has been removed as providing a custom
`names<-().linelist` method is sufficient to ensure compatibility with 
`dplyr::rename()`, including appropriate modification of the tags. (@Bisaloo, 
#60)

## Documentaiton

* added a hex logo thanks to David Mascarina's contribution

* added short lay description to README thanks to Emma Marty's contribution

## Bug fixes

* linelist is now explicitly marked as incompatible with data.table. 
In practice, `make_linelist(x)` now errors if `x` inherits from `data.table` 
(#55, @Bisaloo, based on discussions with @TimTaylor).
* `[.linelist()` now works to subset by column when including just one argument 
(#54, @Bisaloo). E.g., `x[1]`. As an indirect effect, this also improves
compatibility with dplyr verbs that rely on this method (#51).
* subsetting a linelist with extra tags (e.g., created via 
`make_linelist(allow_extra = TRUE)`) no longer causes an error (#65, @Bisaloo; 
reported by @TimTaylor in #63)

## Internal changes

* testthat tests now run in parallel (#76, @Bisaloo)
* testthat tests now warn on partial matching (#76, @Bisaloo)

# linelist 0.0.1

This is the first proof-of-concept release on CRAN.

## New features

* the `linelist` class implements a tagging system to keep track of key
  epidemiological variables in a `data.frame`
  
* validation routines for tagged variables

* accessors to retrieve tagged variables

* an API for easy extension to additional tagged variables

* dedicated S3 methods providing safeguards for operations which could lose
  tagged variables

* full documentation of all functions

* a vignette

* 100% test coverage


