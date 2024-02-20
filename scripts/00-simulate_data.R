#### Preamble ####
# Purpose: Simulates food bank bidding information
# Author: Zijun Meng
# Date: 15 February 2024
# Contact: zijun.meng@mai.utoronto.ca
# License: MIT
# Pre-requisites: -


#### Workspace setup ####
library(tidyverse)

#### Simulate data ####
set.seed(1453)

country <- c("USA","CANADA")
simulated_data <-
  tibble(
    date = rep(x = as.Date("2023-01-01") + c(0:364), times = 1),
    # Based on Eddelbuettel: https://stackoverflow.com/a/21502386
    pricePerPound = sample(-1:5,365, replace=T) ,
    totalPounds  = sample(1:50000,365, replace=T) ,
    COUNTRYCODE = sample(country,365, replace=T) ,
    type = sample(1:10,365, replace=T) ,
  )
simulated_data
#test
simulated_data$date |> min() == "2023-01-01"
simulated_data$date |> max() == "2023-12-31"
simulated_data$pricePerPound |> min() >= -1
simulated_data$pricePerPound |> max() <= 5
simulated_data$totalPounds |> min() >= 1
simulated_data$totalPounds |> max() <= 50000
simulated_data$COUNTRYCODE %in% country
simulated_data$type |> min() >= 1
simulated_data$type |> max() <= 10
