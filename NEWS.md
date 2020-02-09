## explore 0.5.4 (2020-02-10)

Maintenance update:

* fix param ... in description (PR#16223, see
<https://bugs.r-project.org/bugzilla/show_bug.cgi?id=16223>)


## explore 0.5.3 (2020-01-17)

* explore_bar(): add parameter numeric
* describe_all() returns a tibble
* describe_all(): column 'variable' is character (not factor)
* report() split = TRUE as default
* add rescale01()
* add parameter rescale01 to clean_var()
* add function count_pct()
* add out='tibble' to describe_cat()
* add function explore_targetpct()

## explore 0.5.2 (2019-11-21)

* split scource-code file into multiple files
* format_num_auto without brackets
* treat Date variables as cat
* report() fix automatic file extentison .html
* add simplify_text()
* add parameter simplify_text to clean_var()
* fix link in README.md

## explore 0.5.1 (2019-10-07)

Prepare for new dplyr 0.8.4
Bug Fixes

* prepare explore_tbl() for dplyr 0.8.4
* describe_num() with default digits=6
* describe_cat() bugfix variable with all NA
* describe_all() bugfix variable with all NA
* explain_tree() bugfix dataframe with 0 rows
* improve speed describe() text output (RMarkdown)
* explore() now checks if data is a data.frame

## explore 0.5.0 (2019-09-19)

Interactive data exploration now accept categorical and numerical targets (next to a binary target).

* explain_tree(): target can be bin/num/cat
* explain_tree(): add parameter max_target_cat
* explore_shiny(): target can be bin/num/cat
* add function format_num_auto()
* add function total_fig_height()
* get_nrow() deprecated, use total_fig_height() instead
* add parameter title to explore_cor()
* add support for POSIXct in describe()
* improved handling of dataframes with no observations
* add parameter title to explore_density()
* add parameter nvar to total_fig_height()
* update README.md
* update Vignettes
* add NEWS.md
* add hex sticker

## explore 0.4.4 (2019-08-30)

Many functions now accept categorical and numerical targets (next to a binary target). If you want to force which geom is used for visualisation, you can use explore_bar() and explore_density(). New function explore_tbl() to visualise a dataframe/table (type of variables, number of NA, ...)

* add function explore_bar()
* explore_density() now using correct tidy eval, target cat > 2 possible
* target_explore_cat() now using correct tidy eval
* target_explore_num() now using correct tidy eval
* add plot_var_info() - plots a info-text to a variable as ggplot obj.
* plot_var_info() used in explore/explore_all if <oth>
* plot_var_info() used if explore empty data
* add parameter max_cat in explore_bar(), explore_density() and explain_tree()
* add explore_tbl()
* drop explore_cat() & explore_num()
* rename template_report_target_den.html > _split.html
* intelligent placing of labels in plots
* add info window "generating report ..." in explore_shiny
* format_num() -> format_num_kMB(), format_num_space()
* format_target -> if numeric split 0/1 by mean
* report() -> default .html file extension
* consistency showing NA info in explore-title
* parameter split: default = FALSE
* allow numeric (num) target in explore_all & report
* describe_tbl() -> fix target if not bin
* desribe(): change out="vector" to out="list"

## explore 0.4.3 (2019-06-20)

* fix parameter in explore: auto_scale, na
* fix number of NA in explore (move code before auto_scale)
* explore_density() with target: drop plot title "propensity by"
* explore_shiny(): use output_dir / tempdir()
* change naming "attribute" to "variable" (consistent)
