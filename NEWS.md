# linelist 0.0.2

## New features

* The custom `rename.linelist()` method has been removed as providing a custom
`names<-().linelist` method is sufficient to ensure compatibility with 
`dplyr::rename()`, including appropriate modification of the tags. (@Bisaloo, 
#60)

* added a hex logo thanks to David Mascarina's contribution

* added short lay description to README thanks to Emma Marty's contribution


## Bug fixes

* linelist is now explicitly marked as incompatible with data.table. 
In practice, `make_linelist(x)` now errors if `x` inherits from `data.table` 
(#55, @Bisaloo, based on discussions with @TimTaylor).
* `[.linelist()` now works to subset by column when including just one argument 
(#54, @Bisaloo). E.g., `x[1]`. As an indirect effect, this also improves
compatibility with dplyr verbs that rely on this method (#51).

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


