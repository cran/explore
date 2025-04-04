#' Create an empty dataset
#'
#' @param obs Number of observations
#' @param add_id Add an id
#' @return Dataset as tibble
#' @examples
#' create_data_empty(obs = 100)
#' create_data_empty(obs = 100, add_id = TRUE)
#' @export

create_data_empty <- function(obs = 1000, add_id = FALSE) {

  # checks
  check_number_whole(obs, min = 1)
  check_bool(add_id)

  # create empty data frame
  data <- data.frame(
    row.names = seq_len(obs)
  )

  # add if
  if (add_id)  {
    data[["id"]] <- seq_len(obs)
  }

  # return data
  tibble::as_tibble(data)

} # create_data_empty

#' Create data app
#'
#' Artificial data that can be used for unit-testing or teaching
#'
#' @param obs Number of observations
#' @param add_id Add an id-variable to data?
#' @param seed Seed for randomization (integer)
#' @return A dataset as tibble
#' @examples
#' create_data_app()
#' @export

create_data_app = function(obs = 1000,
                           add_id = FALSE,
                           seed = 123) {
  # checks
  check_number_whole(obs, min = 1)
  check_bool(add_id)
  check_number_decimal(seed)

  # set seed (randomization)
  set.seed(seed)

  data <- create_data_empty(obs = obs) %>%
    add_var_id(name = "id")

  data <- data %>%
    add_var_random_cat("os", c("iOS", "Android", "Other"), prob = c(0.4, 0.5, 0.1)) %>%
    add_var_random_01("free", prob = c(0.4, 0.6)) %>%
    add_var_random_int("downloads", min_val = 0, max_val = 7500) %>%
    add_var_random_cat("rating", c(1L,2L,3L,4L,5L), prob = c(0.15, 0.1, 0.05, 0.5, 0.2)) %>%
    add_var_random_cat("type", c("Games", "Connect", "Work", "Learn", "Media", "Shopping", "Tools", "Kids", "Travel", "Other"), prob = c(0.15,0.05,0.05,0.1,0.1,0.1,0.1,0.1,0.1,0.15)) %>%
    add_var_random_int("updates", min_val = 0, max_val = 100) %>%
    add_var_random_int("screen_sizes", min_val = 1, max_val = 5)

  set.seed(123) # to make it reproducible

  # add effect free
  prob <- 0.7
  size <- 5000
  data$downloads <- ifelse(stats::runif(nrow(data)) <= prob,
                           data$downloads + (data$free * stats::runif(nrow(data)) * size),
                           data$downloads)

  # add effect rating
  prob <- 0.8
  size <- 1000
  data$downloads <- ifelse(stats::runif(nrow(data)) <= prob,
                           data$downloads + (data$rating * stats::runif(nrow(data)) * size),
                           data$downloads)

  # add effect type=GAME
  prob <- 0.4
  size <- 3000
  data$downloads <- ifelse(stats::runif(nrow(data)) <= prob,
                           data$downloads + ifelse(data$type == "Games", stats::runif(nrow(data)) * size, 0),
                           data$downloads)

  # add effect os=iOS
  data$rating <- ifelse(data$os == "iOS" & data$rating == 1 & stats::runif(nrow(data)) > 0.6,
                        5,
                        data$rating)
  data$downloads <- ifelse(data$os == "Android",
                           data$downloads * 1.3,
                           data$downloads)


  # add effect os=Other
  data$downloads <- ifelse(data$os == "Other",
                           data$downloads/2,
                           data$downloads)
  data$updates <- ifelse(data$os == "Other",
                         data$updates/3,
                         data$updates)
  data$rating <- ifelse(data$os == "Other" & data$rating >= 3 & stats::runif(nrow(data)) > 0.3,
                        1,
                        data$rating)

  # add effect iOS screen-size <= 2 (iOs/iPad)
  data$screen_sizes <- ifelse(data$os == "iOS" & data$screen_sizes > 2,
                              2,
                              data$screen_size)

  # add effect Other screen-size
  data$screen_sizes <- ifelse(data$os == "Android" & data$screen_sizes <= 2 & stats::runif(nrow(data)) > 0.2,
                              3,
                              data$screen_size)

  # add effect Other screen-size
  data$screen_sizes <- ifelse(data$os == "Other" & data$screen_sizes > 1,
                              1,
                              data$screen_size)

  # make downloads int again
  data$downloads <- as.integer(data$downloads)

  # add id?
  if (!add_id)  {
    data$id <- NULL
  }

  # return data
  tibble::as_tibble(data)

} # create_data_app

#' Create data person
#'
#' Artificial data that can be used for unit-testing or teaching
#'
#' @param obs Number of observations
#' @param add_id Add an id
#' @param seed Seed for randomization (integer)
#' @return A dataset as tibble
#' @examples
#' create_data_person()
#' @export

create_data_person <- function(obs = 1000, add_id = FALSE, seed = 123) {

  # checks
  check_number_whole(obs, min = 1)
  check_bool(add_id)
  check_number_decimal(seed)

  # reproducible random numbers
  set.seed(seed)

  # number of observations
  nobs <- obs

  # random data
  data <- tibble::tibble(
    age = sample(16:95, nobs, replace = TRUE),
    gender = sample(c("Male","Female", "X"), prob = c(0.49, 0.49, 0.02), nobs, replace = TRUE),
    eye_color = sample(c("Blue","Green","Brown"), size = nobs, replace = TRUE),
    shoe_size = trunc(stats::rnorm(nobs, mean = 43, sd = 3)),
    iq = trunc(stats::rnorm(nobs, mean = 100, sd = 20)),
    education = sample(c(0:100), nobs, replace = TRUE),
    income = sample(c(0:100), nobs, replace = TRUE),

    handset = sample(c("Apple","Android", "Other"), prob = c(0.4,0.5, 0.1), nobs, replace = TRUE),

    pet = sample(c("Dog","Cat","Other","No"),
                 prob = c(0.23,0.22,0.11,0.35),
                nobs, replace = TRUE),

    favorite_pizza = sample(c("Margaritha", "Carciofi","Pepperoni", "Hawai", "Quattro Statgioni", "Provenciale"), nobs, replace = TRUE),
    favorite_icecream = sample(c("Vanilla", "Chocolate","Strawberry", "Lemon", "Cookie", "Hazelnut","Apple"),
                               prob=c(0.3,0.2,0.2,0.1,0.1,0.05,0.05),
                               nobs, replace = TRUE),
    likes_garlic = as.integer(sample(0:1, nobs, prob = c(0.4, 0.6), replace = TRUE)),
    likes_sushi = as.integer(sample(0:1, nobs, prob = c(0.5, 0.5), replace = TRUE)),
    likes_beatles = as.integer(sample(0:1, nobs, prob = c(0.6, 0.4), replace = TRUE)),
    likes_beer = as.integer(sample(0:1, nobs, prob = c(0.6, 0.4), replace = TRUE))
  )

  # not random correlations
  random01 <- stats::runif(nobs)
  data$likes_beatles <- ifelse(data$likes_beatles + data$age/50 * random01>= 1, 1L, 0L)
  data$likes_beer <- ifelse(data$gender == "Male" & random01 >= 0.2, 1L, data$likes_beer)
  data$likes_sushi <- ifelse(data$age/75 + random01/4 >= 1, 0L, data$likes_sushi)
  data$shoe_size <- ifelse(data$gender == "Female"  & random01 >= 0.3, data$shoe_size - 1.8, data$shoe_size)
  data$income <- ifelse(data$education > 50 & random01 > 0.3, data$income + data$education/2, data$income)
  data$handset <- ifelse(data$handset == "Android" & data$income>75 & data$education<25, "Apple", data$handset)
  # add extreme values
  #data[1,"age"] <- 5000

  # add id variable?
  if(add_id) {
    data <- data %>% add_var_id(name = "id")
  }

  # return data
  tibble::as_tibble(data)

} #create_data_person


#' Create data buy
#'
#' Artificial data that can be used for unit-testing or teaching
#'
#' Variables in dataset:
#' * id = Identifier
#' * period = Year & Month (YYYYMM)
#' * city_ind = Indicating if customer is residing in a city (1 = yes, 0 = no)
#' * female_ind = Gender of customer is female (1 = yes, 0 = no)
#' * fixedvoice_ind = Customer has a fixed voice product (1 = yes, 0 = no)
#' * fixeddata_ind = Customer has a fixed data product (1 = yes, 0 = no)
#' * fixedtv_ind = Customer has a fixed TV product (1 = yes, 0 = no)
#' * mobilevoice_ind = Customer has a mobile voice product (1 = yes, 0 = no)
#' * mobiledata_prd = Customer has a mobile data product (NO/MOBILE STICK/BUSINESS)
#' * bbi_speed_ind = Customer has a Broadband Internet (BBI) with extra speed
#' * bbi_usg_gb = Broadband Internet (BBI) usage in Gigabyte (GB) last month
#' * hh_single = Expected to be a Single Household (1 = yes, 0 = no)
#'
#' Target in dataset:
#' * buy (may be renamed) = Did customer buy a new product in next month?
#' (1 = yes, 0 = no)
#' @param obs Number of observations
#' @param target_name Variable name of target
#' @param factorise_target Should target variable be factorised?
#' (from 0/1 to factor no/yes)?
#' @param target1_prob Probability that target = 1
#' @param add_extreme Add an observation with extreme values?
#' @param flip_gender Should Male/Female be flipped in data?
#' @param add_id Add an id-variable to data?
#' @param seed Seed for randomization
#' @return A dataset as tibble
#' @examples
#' create_data_buy()
#' @export

create_data_buy = function(obs = 1000,
                           target_name = "buy",
                           factorise_target = FALSE,
                           target1_prob = 0.5,
                           add_extreme = TRUE,
                           flip_gender = FALSE,
                           add_id = FALSE,
                           seed = 123) {

  # checks
  check_number_whole(obs, min = 1)
  check_bool(add_id)
  check_number_decimal(seed)
  check_number_decimal(target1_prob, min = 0, max = 1)

  # define variables for CRAN-package check
  target_ind <- NULL
  age <- NULL
  city_ind <- NULL

  # set seed (randomization)
  set.seed(seed)

  # create basic dataset
  data <- data.frame(
    id = as.integer(seq(from = 1, to = obs)),
    period = as.integer(rep(202012, obs)),
    target_ind = sample(
      c(0L, 1L),
      obs,
      prob = c(1 - target1_prob, target1_prob),
      replace = TRUE)
  )

  # add features
  data <- data %>%
    dplyr::mutate(
      age = as.integer(round(ifelse(target_ind == 1,
                         stats::rnorm(obs, mean = 45, sd = 10),
                         stats::rnorm(obs, mean = 60, sd = 10)
      ), 0)),
      city_ind = ifelse(target_ind == 1,
                        sample(c(0L, 1L), obs, replace = TRUE, prob = c(0.4, 0.6)),
                        sample(c(0L, 1L), obs, replace = TRUE, prob = c(0.6, 0.4))
      ),
      female_ind = ifelse(target_ind == 1,
                          sample(c(0L, 1L), obs, replace = TRUE, prob = c(0.3, 0.7)),
                          sample(c(0L, 1L), obs, replace = TRUE, prob = c(0.7, 0.3))
      ),
      fixedvoice_ind = ifelse(age > 70,
                              sample(c(0L, 1L), obs, replace = TRUE, prob = c(0.3, 0.7)),
                              sample(c(0L, 1L), obs, replace = TRUE, prob = c(0.95, 0.05))
      ),
      fixeddata_ind = 1L,
      fixedtv_ind = ifelse(target_ind == 1,
                           sample(c(0L, 1L), obs, replace = TRUE, prob = c(0.4, 0.6)),
                           sample(c(0L, 1L), obs, replace = TRUE, prob = c(0.8, 0.2))
      ),
      mobilevoice_ind = sample(c(0L, 1L), obs, replace = TRUE, prob = c(0.4, 0.6)),
      mobiledata_prd = sample(c("NO","MOBILE STICK", "BUSINESS"), obs, replace = TRUE, prob = c(0.5, 0.3, 0.2)),
      bbi_speed_ind = ifelse(age > 60,
                             sample(c(0L, 1L), obs, replace = TRUE, prob = c(0.9, 0.1)),
                             sample(c(0L, 1L), obs, replace = TRUE, prob = c(0.2, 0.8))
      ),
      bbi_usg_gb = as.integer(ifelse(age > 75,
                          round(stats::rnorm(obs, mean = 10, sd = 1)),
                          round(stats::rnorm(obs, mean = 50, sd = 10))
      ) + city_ind * 20 + target_ind * 10),
      hh_single = ifelse(age < 35 & city_ind == 1,
                         sample(c(0L, 1L), obs, replace = TRUE, prob = c(0.2, 0.8)),
                         sample(c(0L, 1L), obs, replace = TRUE, prob = c(0.7, 0.3))
      )
    ) # mutate

  # add extreme values?
  if (add_extreme) {
    extreme <- data[nrow(data), ]
    extreme$bbi_usg_gb <- 100000L
    extreme$target_ind <- 0L
    data[nrow(data), ] <- extreme[1, ]
  }

  # factorise target?
  if (factorise_target) {
    data$target_ind <- factor(data$target_ind,
                              levels = c(0, 1),
                              labels = c("no", "yes"))
  }

  # rename target?
  if (target_name != "target_ind") {
    names(data)[[grep("target_ind", names(data))]] <- target_name
  }

  # flip gender?
  if (flip_gender) {
    data[["female_ind"]] <- ifelse(data[["female_ind"]] == 1, 0, 1)
  }

  # add id?
  if (!add_id)  {
    data$id <- NULL
  }

  # return data
  tibble::as_tibble(data)

} # create_data_buy


#' Create data churn
#'
#' Artificial data that can be used for unit-testing or teaching
#'
#' @param obs Number of observations
#' @param target_name Variable name of target
#' @param factorise_target Should target variable be factorised?
#' @param target1_prob Probability that target = 1
#' @param add_id Add an id-variable to data?
#' @param seed Seed for randomization (integer)
#' @return A dataset as tibble
#' @examples
#' create_data_churn()
#' @export

create_data_churn = function(obs = 1000,
                             target_name = "churn",
                             factorise_target = FALSE,
                             target1_prob = 0.4,
                             add_id = FALSE,
                             seed = 123) {

  # checks
  check_number_whole(obs, min = 1)
  check_bool(add_id)
  check_number_decimal(seed)
  check_number_decimal(target1_prob, min = 0, max = 1)

  # set seed (randomization)
  set.seed(seed)

  data <- create_data_empty(obs = obs) %>%
    add_var_id(name = "id")

  data <- data %>%
    add_var_random_int("price", min_val = 9, max_val = 29) %>%
    add_var_random_cat("type", c("Regular", "Promo", "Premium"), prob = c(0.30, 0.50, 0.20)) %>%
    add_var_random_int("usage", min_val = 0, max_val = 100) %>%
    add_var_random_01("shared", prob = c(0.6, 0.4)) %>%
    add_var_random_cat("device", c("Phone", "Tablet", "Computer"), prob = c(0.5, 0.25, 0.25)) %>%
    add_var_random_01("newsletter", prob = c(0.5, 0.5)) %>%
    add_var_random_cat("language", c("en", "sp", "de", "fr"), prob = c(0.5, 0.3, 0.1, 0.1)) %>%
    add_var_random_int("duration", min_val = 0, max_val = 100) %>%
    add_var_random_01("churn", prob = c(1 - target1_prob, target1_prob))


  set.seed(123) # to make it reproducible

  # add effect Promo
  prob <- 0.4
  change <- stats::runif(nrow(data)) <= prob &
    data$type == "Promo"
  data$price[change] <- data$price[change] - 5

  # add effect Premium
  prob <- 0.5
  change <- stats::runif(nrow(data)) <= prob &
    data$type == "Premium"
  data$price[change] <- 29

  # add effect shared
  prob <- 0.5
  change <- stats::runif(nrow(data)) <= prob &
    data$shared == 1
  data$usage[change] <- data$usage[change] * 1.5

  # add effect churn type=Premium
  prob <- 0.3
  change <- stats::runif(nrow(data)) <= prob &
    data$price >= 22
  data$churn[change] <- 1

  # add effect churn newsletter=1
  prob <- 0.3
  change <- stats::runif(nrow(data)) <= prob &
    data$newsletter == 1
  data$churn[change] <- 0

  # add effect churn shared=1
  prob <- 0.3
  change <- stats::runif(nrow(data)) <= prob &
    data$shared == 1
  data$churn[change] <- 0

  # factorise target?
  if (factorise_target) {
    data$churn <- factor(data$churn,
                              levels = c(0, 1),
                              labels = c("no", "yes"))
  }

  # rename target?
  if (target_name != "churn") {
    names(data)[[grep("churn", names(data))]] <- target_name
  }

  # add id?
  if (!add_id)  {
    data$id <- NULL
  }

  # return data
  tibble::as_tibble(data)

} # create_data_churn


#' Create data newsletter
#'
#' Artificial data that can be used for unit-testing or teaching
#' (fairness & AI bias)
#' @param obs Number of observations
#' @param add_id Add an id-variable to data?
#' @param seed Seed for randomization (integer)
#' @return A dataset as tibble
#' @examples
#' create_data_newsletter()
#' @export

create_data_newsletter = function(obs = 1000,
                              add_id = FALSE,
                              seed = 123) {
  # checks
  check_number_whole(obs, min = 1)
  check_bool(add_id)
  check_number_decimal(seed)

  # define variables for CRAN-package check
  sending_h <- NULL
  message <- NULL
  age <- NULL
  send <- NULL
  click <- NULL
  buy <- NULL

  # randomize
  set.seed(seed)

  # create dataframe and variables
  data <- create_data_empty(obs) %>%
      add_var_random_int("sending_h", min_val = 12, max_val = 16) %>%
      add_var_random_cat("message", c("voucher", "news")) %>%
      add_var_random_int("age", min_val = 16, max_val = 80) %>%
      add_var_random_01("send", prob = c(0.05, 0.95)) %>%
      add_var_random_01("click", prob = c(0.3, 0.7)) %>%
      add_var_random_01("buy", prob = c(0.1, 0.9))

  # click only if send, buy only if click
  data <- data %>%
      mutate(click = ifelse(send == 1, click, 0)) %>%
      mutate(buy = ifelse(click == 1, buy, 0))

  # higher age, higher click
  data <- data %>%
      mutate(click = ifelse(stats::runif(obs, min = 1, max = 100) + age > 80,
                            click, 0))
  # message news (not voucher), lower click
  data <- data %>%
    mutate(click = ifelse(stats::runif(obs, min = 1, max = 100) > 80 &
                          message == "news",
                          0, click))

  # lower age, higher buy
  data <- data %>%
    mutate(buy = ifelse(stats::runif(obs, min = 1, max = 100) + age < 80,
                        buy, 0))

  # click only if send, buy only if click
  data <- data %>%
    mutate(click = ifelse(send == 1, click, 0)) %>%
    mutate(buy = ifelse(click == 1, buy, 0))

  # add an id?
  if (add_id)  {
    data <- data %>% add_var_id()
  }

  # return data
  tibble::as_tibble(data)

} # create_data_newsletter


#' Create data unfair
#'
#' Artificial data that can be used for unit-testing or teaching
#' (fairness & AI bias)
#' @param obs Number of observations
#' @param target_name Variable name of target
#' @param factorise_target Should target variable be factorised?
#' @param target1_prob Probability that target = 1
#' @param add_id Add an id-variable to data?
#' @param seed Seed for randomization (integer)
#' @return A dataset as tibble
#' @examples
#' create_data_unfair()
#' @export

create_data_unfair = function(obs = 1000,
                              target_name = "target_ind",
                              factorise_target = FALSE,
                              target1_prob = 0.25,
                              add_id = FALSE,
                              seed = 123) {
  # checks
  check_number_whole(obs, min = 1)
  check_bool(add_id)
  check_number_decimal(seed)
  check_number_decimal(target1_prob, min = 0, max = 1)

  # set seed (randomization)
  set.seed(seed)

  # start with data_person
  data <- create_data_person(obs = obs, add_id = add_id, seed = seed)
  data$favorite_pizza <- NULL
  data$favorite_icecream <- NULL
  data$likes_beer <- NULL
  data$likes_beatles <- NULL
  data$likes_garlic <- NULL
  data$likes_sushi <- NULL

  # add additonal variables
  data <- data %>%
    add_var_random_01("smoking", prob = c(0.7, 0.3)) %>%
    add_var_random_01("name_arabic", prob = c(0.8, 0.2)) %>%
    add_var_random_cat("outfit", cat = c("Alternative", "Casual", "Elegant"), prob = c(0.1, 0.5, 0.4)) %>%
    add_var_random_01("glasses", prob = c(0.65, 0.35)) %>%
    add_var_random_01("tatoos", prob = c(0.80, 0.20)) %>%
    add_var_random_cat("pet", cat = c("Cat", "Dog", "Other", "No")) %>%
    add_var_random_01("kids") %>%
    add_var_random_cat("bad_debt", cat = c(0,1,2), prob = c(0.8, 0.15, 0.05)) %>%
    add_var_random_cat("credit_card", cat = c("Master", "Visa", "Other", "No"), prob = c(0.4, 0.4, 0.1, 0.1)) %>%
    add_var_random_01("left_handed", prob = c(0.8, 0.2)) %>%
    add_var_random_cat("skin_color", cat = c("White", "Black", "Brown", "Yellow", "Red"), prob = c(0.75,0.1,0.05,0.09,0.01)) %>%
    add_var_random_cat("religion", cat = c("Christian", "Muslim", "Other", "No"), prob = c(0.55,0.15,0.10,0.20)) %>%
    add_var_random_dbl("internet_gb", min_val = 0, max_val = 500, seed = 5)

  # not random correlations
  data$eye_color <- ifelse(data$skin_color == "White" & stats::runif(nrow(data)) > 0.4, "Blue", data$eye_color)
  data$eye_color <- ifelse(data$skin_color == "Black" & stats::runif(nrow(data)) > 0.3, "Brown", data$eye_color)
  data$eye_color <- ifelse(data$skin_color == "Red" & stats::runif(nrow(data)) > 0.1, "Brown", data$eye_color)
  data$religion <- ifelse(data$skin_color %in% c("Yellow", "Red") & stats::runif(nrow(data)) > 0.2, "Other", data$religion)
  data$name_arabic <- ifelse(data$religion == "Other" & data$eye_color != "Blue",
                             sample(0:1, nrow(data), prob = c(0.5,0.5), replace = TRUE),
                             sample(0:1, nrow(data), prob = c(0.9,0.1), replace = TRUE))
  data$internet_gb <- data$internet_gb - data$age*3
  data$internet_gb <- ifelse(data$internet_gb < 0, 0, data$internet_gb)
  # add target
  data <- data %>%
    add_var_random_01(name = "target", prob = c(1 - target1_prob, target1_prob))

  # add pattern for target
  data$target <- ifelse(data$age <= 20 & data$handset == "Apple" & stats::runif(nrow(data)) > 0.6, 1, data$target)
  data$target <- ifelse(data$age > 20 & data$age < 70 & data$gender == "Female" & stats::runif(nrow(data)) > 0.6, 0, data$target)
  data$target <- ifelse(data$age > 75 & stats::runif(nrow(data)) > 0.6, 1, data$target)
  data$target <- ifelse(data$bad_debt > 0 & stats::runif(nrow(data)) > 0.8, 1, data$target)
  data$target <- ifelse(data$bad_debt > 1 & stats::runif(nrow(data)) > 0.8, 1, data$target)
  data$target <- ifelse(data$income < 50 & data$credit_card == "Other" & stats::runif(nrow(data)) > 0.5, 1, data$target)
  data$target <- ifelse(data$credit_card == "Other" & stats::runif(nrow(data)) > 0.8, 1, data$target)
  data$target <- as.integer(data$target)

  # factorise target?
  if (factorise_target) {
    data$target <- factor(data$target,
                              levels = c(0, 1),
                              labels = c("no", "yes"))
  }

  # rename target?
  if (target_name != "target") {
    data[[target_name]] <- data$target
    data$target <- NULL
  }

  # return data
  tibble::as_tibble(data)

} # create_data_unfair()

#' Create data random
#'
#' Random data that can be used for unit-testing or teaching
#'
#' Variables in dataset:
#' * id = Identifier
#' * var_X = variable containing values between 0 and 100
#'
#' Target in dataset:
#' * target_ind (may be renamed) = random values (1 = yes, 0 = no)
#'
#' @param obs Number of observations
#' @param vars Number of variables
#' @param target_name Variable name of target
#' @param factorise_target Should target variable be factorised?
#' (from 0/1 to facotr no/yes)?
#' @param target1_prob Probability that target = 1
#' @param add_id Add an id-variable to data?
#' @param seed Seed for randomization
#' @return A dataset as tibble
#' @examples
#' create_data_random(obs = 100, vars = 5)
#' @export

create_data_random = function(obs = 1000, vars = 10,
                              target_name = "target_ind",
                              factorise_target = FALSE,
                              target1_prob = 0.5,
                              add_id = TRUE,
                              seed = 123) {
  # checks
  check_number_whole(obs, min = 1)
  check_bool(add_id)
  check_number_decimal(seed)
  check_number_decimal(target1_prob, min = 0, max = 1)

  # set seed (randomization)
  set.seed(seed)

  # create basic dataset
  data <- data.frame(
    id = seq(from = 1, to = obs),
    target_ind = sample(c(0L, 1L),
                        obs,
                        prob = c(1 - target1_prob, target1_prob),
                        replace = TRUE)
  )

  # add features
  for (i in seq_len(vars)) {
    data[[paste0("var_",i)]] <- as.integer(
      round(stats::runif(obs)*100,0))
  }


  # factorise target?
  if (factorise_target) {
    data$target_ind <- factor(data$target_ind,
                              levels = c(0, 1),
                              labels = c("no", "yes"))
  }

  # rename target?
  if (target_name != "target_ind") {
    data[[target_name]] <- data$target_ind
    data$target_ind <- NULL
  }

  # add id?
  if (!add_id)  {
    data$id <- NULL
  }

  # return data
  tibble::as_tibble(data)

} # create_data_random

#' Create data esoteric
#'
#' Random data that can be used for unit-testing or teaching
#'
#' Variables in dataset:
#' * id = Identifier
#' * starsign = random starsign
#' * chinese = random chinese zodiac
#' * moon = random moon phase
#' * blood = random blood type
#' * fingers_crossed = random fingers crossed (1 = yes, 0 = no)
#' * success = random success (1 = yes, 0 = no)
#' @param obs Number of observations
#' @param add_id Add an id-variable to data?
#' @param seed Seed for randomization
#' @return A dataset as tibble
#' @examples
#' create_data_esoteric(obs = 100)
#' @export

create_data_esoteric = function(obs = 1000, add_id = FALSE, seed = 123) {

  # checks
  check_number_whole(obs, min = 1)
  check_bool(add_id)
  check_number_decimal(seed)

  # set seed (randomization)
  set.seed(seed)

  # create data
  data <- create_data_empty(obs = obs) %>%
    add_var_id() %>%
    add_var_random_starsign("starsign") %>%
    add_var_random_cat(
      "chinese",
      cat = c("Rat", "Ox", "Tiger", "Rabbit", "Dragon", "Snake", "Horse", "Goat",
              "Monkey", "Rooster", "Dog", "Pig"),
      prob = rep(1/12, 12)
    ) %>%
    add_var_random_moon("moon") %>%
    add_var_random_cat(
      "blood",
      cat = c("0+", "A+", "B+", "AB+", "A-", "0-", "B-", "AB-"),
      prob = c(0.35, 0.37, 0.09, 0.04, 0.06, 0.06, 0.02, 0.01)
    ) %>%
    add_var_random_01("fingers_crossed", prob = c(0.8, 0.2)) %>%
    add_var_random_01("success")

  # add id?
  if (!add_id)  {
    data$id <- NULL
  }

  # return data
  tibble::as_tibble(data)

} # create_data_esoteric

#' Create data of A/B testing
#'
#' Data that can be used for unit-testing or teaching
#'
#' @param n_a Total size of group A
#' @param n_b Total size of group B
#' @param success_a Success in group A
#' @param success_b Success in group B
#' @param success_unit Unit ("count"|"percent")
#' @param count Create as count-data (FALSE|TRUE)
#' @return A dataset as tibble
#' @examples
#' library(dplyr)
#' create_data_abtest() %>% abtest()
#' create_data_abtest(
#'   n_a = 100,
#'   n_b = 100,
#'   success_a = 20,
#'   success_b = 30,
#'   success_unit = "count"
#' ) %>% abtest()
#' @export

create_data_abtest <- function(n_a = 100, n_b = 100,
                               success_a = 10, success_b = 5,
                               success_unit = "count", count = TRUE)  {
  ## Define variables to pass CRAN check
  random_int <- NULL

  # check unit
  if (success_unit == "percent") {
    success_a <- round(n_a * success_a/100, 0)
    success_b <- round(n_b * success_b/100, 0)
  }

  # create count data
  data <- data.frame(
    group = c('A', 'A', 'B', 'B'),
    n = c(n_a - success_a, success_a, n_b - success_b, success_b),
    success = c(0, 1, 0, 1)
  )

  # uncount if necessary
  if (count) {
    data
  } else {
    data <- uncount_compat(data, n) %>% add_var_random_int()
    data %>% arrange(random_int) %>% select(-random_int)
  }

} #create_data_abtest

