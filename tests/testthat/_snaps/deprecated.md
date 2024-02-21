# deprecating warning for select_tags()

    Code
      select_tags(x, "date_onset", "age")
    Condition
      Warning:
      `select_tags()` was deprecated in linelist 1.0.0.
      i This function is deprecated: use the two step `tags_df()` and `dplyr::select()` process instead
    Output
         date_onset age
      1           2   4
      2          10   4
      3           4   7
      4          22   7
      5          16   8
      6          10   9
      7          18  10
      8          26  10
      9          34  10
      10         17  11
      11         28  11
      12         14  12
      13         20  12
      14         24  12
      15         28  12
      16         26  13
      17         34  13
      18         34  13
      19         46  13
      20         26  14
      21         36  14
      22         60  14
      23         80  14
      24         20  15
      25         26  15
      26         54  15
      27         32  16
      28         40  16
      29         32  17
      30         40  17
      31         50  17
      32         42  18
      33         56  18
      34         76  18
      35         84  18
      36         36  19
      37         46  19
      38         68  19
      39         32  20
      40         48  20
      41         52  20
      42         56  20
      43         64  20
      44         66  22
      45         54  23
      46         70  24
      47         92  24
      48         93  24
      49        120  24
      50         85  25

# deprecating warning for select.linelist()

    Code
      select(x, tags = c("date_onset", "age"))
    Condition
      Warning:
      The `tags` argument of `select()` is deprecated as of linelist 1.0.0.
      i It is now recommended to leverage the `has_tag()` selection helper rather than this argument.
    Output
      
      // linelist object
         speed dist
      1      4    2
      2      4   10
      3      7    4
      4      7   22
      5      8   16
      6      9   10
      7     10   18
      8     10   26
      9     10   34
      10    11   17
      11    11   28
      12    12   14
      13    12   20
      14    12   24
      15    12   28
      16    13   26
      17    13   34
      18    13   34
      19    13   46
      20    14   26
      21    14   36
      22    14   60
      23    14   80
      24    15   20
      25    15   26
      26    15   54
      27    16   32
      28    16   40
      29    17   32
      30    17   40
      31    17   50
      32    18   42
      33    18   56
      34    18   76
      35    18   84
      36    19   36
      37    19   46
      38    19   68
      39    20   32
      40    20   48
      41    20   52
      42    20   56
      43    20   64
      44    22   66
      45    23   54
      46    24   70
      47    24   92
      48    24   93
      49    24  120
      50    25   85
      
      // tags: date_onset:dist, age:speed 

# deprecating warning for make_linelist(x, list())

    Code
      make_linelist(cars, list(date_onset = "dist", age = "speed"))
    Condition
      Warning in `make_linelist()`:
      The use of a list of tags is deprecated. Please use the splice operator (!!!) instead. More information is available in the examples and in the ?rlang::`dyn-dots` documentation.
    Output
      
      // linelist object
         speed dist
      1      4    2
      2      4   10
      3      7    4
      4      7   22
      5      8   16
      6      9   10
      7     10   18
      8     10   26
      9     10   34
      10    11   17
      11    11   28
      12    12   14
      13    12   20
      14    12   24
      15    12   28
      16    13   26
      17    13   34
      18    13   34
      19    13   46
      20    14   26
      21    14   36
      22    14   60
      23    14   80
      24    15   20
      25    15   26
      26    15   54
      27    16   32
      28    16   40
      29    17   32
      30    17   40
      31    17   50
      32    18   42
      33    18   56
      34    18   76
      35    18   84
      36    19   36
      37    19   46
      38    19   68
      39    20   32
      40    20   48
      41    20   52
      42    20   56
      43    20   64
      44    22   66
      45    23   54
      46    24   70
      47    24   92
      48    24   93
      49    24  120
      50    25   85
      
      // tags: date_onset:dist, age:speed 

# deprecating warning for list in set_tags()

    Code
      set_tags(x, list(date_onset = "dist", age = "speed"))
    Condition
      Warning in `set_tags()`:
      The use of a list of tags is deprecated. Please use the splice operator (!!!) instead. More information is available in the examples and in the ?rlang::`dyn-dots` documentation.
    Output
      
      // linelist object
         speed dist
      1      4    2
      2      4   10
      3      7    4
      4      7   22
      5      8   16
      6      9   10
      7     10   18
      8     10   26
      9     10   34
      10    11   17
      11    11   28
      12    12   14
      13    12   20
      14    12   24
      15    12   28
      16    13   26
      17    13   34
      18    13   34
      19    13   46
      20    14   26
      21    14   36
      22    14   60
      23    14   80
      24    15   20
      25    15   26
      26    15   54
      27    16   32
      28    16   40
      29    17   32
      30    17   40
      31    17   50
      32    18   42
      33    18   56
      34    18   76
      35    18   84
      36    19   36
      37    19   46
      38    19   68
      39    20   32
      40    20   48
      41    20   52
      42    20   56
      43    20   64
      44    22   66
      45    23   54
      46    24   70
      47    24   92
      48    24   93
      49    24  120
      50    25   85
      
      // tags: date_onset:dist, age:speed 

