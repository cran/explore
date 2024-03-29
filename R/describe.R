#' Describe numerical variable
#'
#' @param data A dataset
#' @param var Variable or variable name
#' @param n Weights variable for count-data
#' @param out Output format ("text"|"list")
#' @param margin Left margin for text output (number of spaces)
#' @return Description as text or list
#' @examples
#' describe_num(iris, Sepal.Length)
#' @export

describe_num <- function(data, var, n, out = "text", margin = 0) {
  # data type data.frame?
  check_data_frame_non_empty(data)

  # parameter var
  rlang::check_required(var)
  var_quo <- enquo(var)
  var_txt <- quo_name(var_quo)[[1]]

  # check if var in data
  if(!var_txt %in% names(data)) {
    stop("variable not found in table")
  }

  # error if var is a factor
  if (is.factor(data[[var_txt]]))  {
    stop("use describe_cat for a factor")
  }

  # check for count data
  if (!missing(n))  {
    n_quo <- enquo(n)
    n_txt <- quo_name(n_quo)[[1]]

    data <- data %>%
      dplyr::select(!!var_quo, !!n_quo) %>%
      uncount_compat(wt = !!n_quo)
  }

  var_name = var_txt
  var_type = get_type(data[[var_name]])

  # datatype supported?
  if (!var_type %in% c("integer", "double", "date"))  {
    stop(paste0("datatype ", var_type, " not supported"))
  }

  var_obs = length(data[[var_name]])
  var_na = sum(is.na(data[[var_name]]))
  var_na_pct = var_na / var_obs * 100

  var_unique = length(unique(data[[var_name]]))
  var_unique_pct = var_unique / var_obs * 100

  var_min = min(data[[var_name]], na.rm = TRUE)
  var_median = median(data[[var_name]], na.rm = TRUE)
  var_mean = mean(data[[var_name]], na.rm = TRUE)
  var_max = max(data[[var_name]], na.rm = TRUE)
  var_quantile = quantile(data[[var_name]], c(0.05, 0.25, 0.75, 0.95), na.rm = TRUE)

  result_num <- list(name = var_name,
                     type = var_type,
                     #guess = var_guess,
                     na = var_na,
                     na_pct = var_na_pct,
                     unique = var_unique,
                     unique_pct = var_unique_pct,
                     min = var_min,
                     quantile = var_quantile,
                     max = var_max,
                     median = var_median,
                     mean = var_mean)

  if (out == "text")  {

    txt <- ""

    spc <- paste(rep(" ", margin), collapse = "")
    txt <- paste0(txt, spc, "variable = ", var_name, "\n")
    #cat("type     =", paste0(var_type, " (cat/num = ", var_guess,")\n"))
    txt <- paste0(txt, spc, "type     = ", var_type,"\n")
    txt <- paste0(txt, spc, "na       = ", format_num_auto(var_na)," of ",format_num_space(var_obs)," (",format_num_auto(var_na_pct),"%)\n")
    txt <- paste0(txt, spc, "unique   = ", format_num_auto(var_unique),"\n")
    txt <- paste0(txt, spc, "min|max  = ", format_num_auto(var_min, digits=6), " | ", format_num_auto(var_max,digits=6), "\n")
    txt <- paste0(txt, spc, "q05|q95  = ", format_num_auto(var_quantile["5%"],digits=6), " | ", format_num_auto(var_quantile["95%"],digits=6), "\n")
    txt <- paste0(txt, spc, "q25|q75  = ", format_num_auto(var_quantile["25%"],digits=6), " | ", format_num_auto(var_quantile["75%"],digits=6), "\n")
    if(var_type == "date")  {
      txt <- paste0(txt, spc, "median   = ", as.character(var_median), "\n")
      txt <- paste0(txt, spc, "mean     = ", as.character(var_mean), "\n")
    } else {
      txt <- paste0(txt, spc, "median   = ", format_num_auto(var_median), "\n")
      txt <- paste0(txt, spc, "mean     = ", format_num_auto(var_mean,digits=6), "\n")
    }
    # print text output
    cat(txt)

  } else {
    result_num
  }
} # describe_num

#' Describe categorical variable
#'
#' @param data A dataset
#' @param var Variable or variable name
#' @param n Weights variable for count-data
#' @param max_cat Maximum number of categories displayed
#' @param out Output format ("text"|"list"|"tibble"|"df")
#' @param margin Left margin for text output (number of spaces)
#' @return Description as text or list
#' @examples
#' describe_cat(iris, Species)
#' @export

describe_cat <- function(data, var, n, max_cat = 10, out = "text", margin = 0) {
  # data table available?
  check_data_frame_non_empty(data)
  # data type data.frame?

  # var
  rlang::check_required(var)
  # non-standard evaluation.
  var_quo <- enquo(var)
  var_txt <- quo_name(var_quo)[[1]]

  # check if var in data
  if(!var_txt %in% names(data)) {
    stop("variable not found in table")
  }

  # check for count data
  if(!missing(n))  {
    n_quo <- enquo(n)
    n_txt <- quo_name(n_quo)[[1]]
    data <- data %>%
      dplyr::select(!!var_quo, !!n_quo) %>%
      uncount_compat(wt = !!n_quo)
  }

  # out = tibble
  if (out %in% c("tibble","df","tbl"))  {
    d <- data %>% count_pct(!!var_quo)
    return(d)
  }

  # out = list | text
  var_name = var_txt
  var_type = ifelse(is.factor(data[[var_name]]),
                    "factor",
                    get_type(data[[var_name]]))

  var_obs = length(data[[var_name]])
  var_na = sum(is.na(data[[var_name]]))
  var_na_pct = ifelse(var_obs > 0,
                      var_na / var_obs * 100,
                      0)

  var_unique = length(unique(data[[var_name]]))

  # define variable for cran check
  grp <- NULL

  # group categorical variable and calculate frequency
  if (var_obs > 0)  {

    var_frequency <- data %>%
      select(grp = !!var_quo) %>%
      count(grp) %>%
      mutate(pct = .data$n / sum(.data$n) * 100) %>%
      mutate(cat_len = nchar(as.character(grp)))

    # limit len of catnames (if not all NA)
    max_cat_len <- 7
    if(nrow(var_frequency) > 0 & !is.na(var_frequency[1,"grp"]))  {
      max_cat_len <- max(var_frequency$cat_len, na.rm = TRUE)
    }

    if(max_cat_len < 7)  {
      max_cat_len = 7
    }
    if(max_cat_len > 20)  {
      max_cat_len = 20
    }

  } else {
    var_frequency <- NA
  } # if

  # result as a list
  result_cat <- list(name = var_name,
                     type = var_type,
                     na = var_na,
                     na_pct = var_na_pct,
                     unique = var_unique,
                     frequency = var_frequency)

  # result as text
  if (out == "text")  {

    txt <- ""

    spc <- paste(rep(" ", margin), collapse = "")
    txt <- paste0(txt, spc, "variable = ", var_name, "\n")
    #cat(paste0(spc, "type     ="), paste0(var_type, " (cat/num = ", var_guess,")\n"))
    txt <- paste0(txt, spc, "type     = ", var_type,"\n")
    txt <- paste0(txt, spc, "na       = ", format_num_space(var_na)," of ",format_num_space(var_obs)," (",format_num_space(var_na_pct),"%)\n")
    txt <- paste0(txt, spc, "unique   = ", format_num_space(var_unique),"\n")

    # show frequency for each category (maximum max_cat)
    if (var_obs > 0)  {
      for (i in seq(min(var_unique, max_cat)))  {
        var_name = format(var_frequency[[i, 1]], width = max_cat_len, justify = "left")
        txt <- paste0(txt, spc, " ", var_name,
                      " = ", format_num_space(var_frequency[[i, 2]]), " (",
                      format_num_space(var_frequency[[i,3]]),"%)\n" )
      } # for
    } # if

    # if more categories than displayed, show "..."
    if (var_unique > max_cat)  {
      txt <- paste0(txt, spc, " ...")
    }

    # print text output
    cat(txt)

  } else {
    result_cat
  }
} # describe_cat


#' Describe all variables of a dataset
#'
#' @param data A dataset
#' @param out Output format ("small"|"large")
#' @return Dataset (tibble)
#' @examples
#' describe_all(iris)
#' @export

describe_all <- function(data, out = "large") {
  # data table available?  data type data.frame?
  check_data_frame_non_empty(data)

  # define variables for package check
  variable <- NULL
  type <- NULL
  na <- NULL
  na_pct <- NULL
  unique <- NULL
  min <- NULL
  mean <- NULL
  max <- NULL

  # define result data.frame
  result <- tibble::tibble(variable = character(),
                       type = character(),
                       na = integer(),
                       na_pct = double(),
                       unique = integer(),
                       min = double(),
                       mean = double(),
                       max = double()
  )

  # names of variables in data
  var_names <- names(data)

  # create plot for each variable
  for(i in seq_along(var_names))  {

    var_name = var_names[i]
    var_obs = length(data[[var_name]])

    var_type = ifelse(is.factor(data[[var_name]]),
                      "fct",
                      format_type(get_type(data[[var_name]])))

    var_na = sum(is.na(data[[var_name]]))

    var_na_pct = ifelse(var_obs > 0,
                        round(var_na / var_obs * 100,1),
                        0)

    var_unique = length(unique(data[[var_name]]))

    if (var_obs > 0 &
        get_type(data[[var_name]]) %in% c("logical","integer","double") &
        !is.factor(data[[var_name]]) &
        var_na < var_obs)  {
      var_min = min(data[[var_name]], na.rm = TRUE)
      var_mean = mean(data[[var_name]], na.rm = TRUE)
      var_max = max(data[[var_name]], na.rm = TRUE)
    } else {
      var_min = NA
      var_mean = NA
      var_max = NA

      #      # if variable is <hide> overrule type as "oth"
      #      if (sum(data[[var_name]] == "<hide>") > 0)  {
      #        var_type = "oth"
      #      }

    } # if

    result <- rbind(result,
                    tibble::tibble(variable = var_name,
                               type = var_type,
                               na = var_na,
                               na_pct = var_na_pct,
                               unique = var_unique,
                               min = round(var_min,2),
                               mean = round(var_mean,2),
                               max = round(var_max,2)
                    ) # data.frame
    ) # rbind
  } # for

  # limit number of columns if out = "small"
  if (out == "small")  {
    result <- select(result, variable, type, na, na_pct)
  }

  # output
  result

} # function describe_all

#' Describe table
#'
#' Describe table (e.g. number of rows and columns of dataset)
#'
#' @param data A dataset
#' @param n Weights variable for count-data
#' @param target Target variable (binary)
#' @param out Output format ("text"|"list")
#' @return Description as text or list
#' @examples
#' describe_tbl(iris)
#'
#' iris[1,1] <- NA
#' describe_tbl(iris)
#' @export

describe_tbl <- function(data, n, target, out = "text")  {

  # data table available?
  check_data_frame_non_empty(data)

  # data type data.frame?

  # parameter target
  if(!missing(target))  {
    target <- enquo(target)
    target_txt <- quo_name(target)[[1]]
    if (!target_txt %in% names(data)) {
      stop(paste0("target variable '", target_txt, "' not found"))
    }
  } else {
    target_txt = NA
  }

  # parameter n
  if(!missing(n))  {
    n_quo <- enquo(n)
    n_txt <- quo_name(n_quo)[[1]]
    if (!n_txt %in% names(data)) {
      stop(paste0("n variable '", n_txt, "' not found"))
    }
  } else {
    n_txt <- NA
  }

  # calculate observations depending on n
  if (is.na(n_txt)) {
    describe_nrow <- nrow(data)
    describe_complete <- sum(complete.cases(data))
  } else {
    describe_nrow <- sum(data[[n_txt]])
    data_complete <- data[complete.cases(data), ]
    describe_complete <- sum(data_complete[[n_txt]])
  }

  # calculate variables
  d <- data %>% describe_all()
  describe_with_na <- sum(ifelse(d$na > 0, 1, 0))
  describe_no_variance <- sum(ifelse(d$unique == 1, 1, 0))
  describe_ncol <- ncol(data)

  # check if target is binary
  describe_target0_cnt <- 0
  describe_target1_cnt <- 0
  target_show <- FALSE

  if (!missing(target)) {
    descr_target <- describe(data, !!target, out = "list")
    target_type <- descr_target$type

    if (descr_target$unique == 2)  {
      target_val <- data[[target_txt]]
      target_val <- format_target(target_val)
      describe_target0_cnt <- sum(ifelse(target_val == 0, 1, 0))
      describe_target1_cnt <- length(target_val) - describe_target0_cnt
      target_show <- TRUE
    }
  }

  # result as a list
  result_list <- list(observations = describe_nrow,
                      complete_obs = describe_complete,
                      variables = describe_ncol,
                      with_na = describe_with_na,
                      no_variance = describe_no_variance,
                      targets = describe_target1_cnt,
                      targets_pct = describe_target1_cnt / describe_nrow * 100)

  # result as text
  if (!missing(target) & target_show == FALSE)  {

    result_text <- paste0(format_num_auto(describe_nrow),
                          " observations with ",
                          format_num_auto(describe_ncol),
                          " variables; ",
                          " target = not binary")
  } else if (!missing(target) & target_show == TRUE) {

    result_text <- paste0(format_num_auto(describe_nrow),
                          " observations with ",
                          format_num_auto(describe_ncol),
                          " variables; ",
                          format_num_space(describe_target1_cnt),
                          " targets (",
                          format_num_space(describe_target1_cnt / describe_nrow * 100, digits = 1),
                          "%)")

  } else {
    result_text <- paste0(format_num_space(describe_nrow),
                          ifelse(describe_nrow >= 1000,
                                 paste0(" (",format_num_kMB(describe_nrow),")"),
                                 ""),
                          " observations with ",
                          format_num_space(describe_ncol),
                          " variables")
  } # if

  # add obs_with_na, vars_with_na and no_variance
  result_text <- paste0(result_text,
                        "\n",
                        format_num_space(describe_nrow - describe_complete), " observations containing missings (NA)",
                        "\n",
                        format_num_space(describe_with_na), " variables containing missings (NA)",
                        "\n",
                        format_num_space(describe_no_variance), " variables with no variance")

  # return output
  if (out == "list")  {
    result_list
  } else {
    cat(result_text)
  }
} # describe_tbl

#' Describe a dataset or variable
#'
#' Describe a dataset or variable (depending on input parameters)
#'
#' @param data A dataset
#' @param var A variable of the dataset
#' @param n Weights variable for count-data
#' @param target Target variable (0/1 or FALSE/TRUE)
#' @param out Output format ("text"|"list") of variable description
#' @param ... Further arguments
#' @return Description as table, text or list
#' @examples
#' # Load package
#' library(magrittr)
#'
#' # Describe a dataset
#' iris %>% describe()
#'
#' # Describe a variable
#' iris %>% describe(Species)
#' iris %>% describe(Sepal.Length)
#' @export

describe <- function(data, var, n, target, out = "text", ...)  {
  # data table available?
  check_data_frame_non_empty(data)


  # parameter var
  if(!missing(var))  {
    var_quo <- enquo(var)
    var_txt <- quo_name(var_quo)[[1]]

    # check if var in data
    if(!var_txt %in% names(data)) {
      stop("variable not found in table")
    }

  } else {
    var_txt = NA
  }

  # parameter target
  if(!missing(target))  {
    target_quo <- enquo(target)
    target_txt <- quo_name(target_quo)[[1]]
  } else {
    target_txt = NA
  }

  # parameter n
  if(!missing(n))  {
    n_quo <- enquo(n)
    n_txt <- quo_name(n_quo)[[1]]
  } else {
    n_txt = NA
  }

  # decide which describe-function to use
  if (is.na(var_txt) & !is.na(target_txt))  {
    describe_tbl(data, target = !!target_quo)
  } else if (is.na(var_txt)) {
    describe_all(data, out = out, ...)
  } else if (!is.na(var_txt)) {

    # reduce variables of data (to improve speed and memory)
   if (is.na(n_txt))  {
      data <- data[var_txt]
   } else {
     data <- data[c(var_txt, n_txt)]
   }

    # describe depending on type (cat/num) and count
    var_guess <- guess_cat_num(data[[var_txt]])
    if ((var_guess == "num") & is.na(n_txt)) {
      describe_num(data, !!var_quo, out = out, ...)
    } else if ((var_guess == "cat") & is.na(n_txt)) {
      describe_cat(data, !!var_quo, out = out, ...)
    } else if ((var_guess == "num") & !is.na(n_txt))  {
      describe_num(data, !!var_quo, n=!!n_quo, out = out, ...)
    } else if ((var_guess == "cat") & !is.na(n_txt))  {
      describe_cat(data, !!var_quo, n=!!n_quo, out = out, ...)
    } else {
      warning("please use a numeric or character variable to describe")
    }
  } # if

} # describe
