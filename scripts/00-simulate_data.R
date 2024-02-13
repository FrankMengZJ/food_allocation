#### Preamble ####
# Purpose: Simulates TTC metro delay information
# Author: Zijun Mneg
# Date: 24 January 2024
# Contact: zijun.meng@mai.utoronto.ca
# License: MIT
# Pre-requisites: -


#### Workspace setup ####
library(tidyverse)

#### Simulate data ####
set.seed(1453)
simulated_delay_data <-
  tibble(
    date = rep(x = as.Date("2023-01-01") + c(0:364), times = 1),
    # Based on Eddelbuettel: https://stackoverflow.com/a/21502386
    delay_reason = sample(1:15,365, replace=T) ,
    delay_min = sample(1:30,365, replace=T) ,
    line = sample(1:4,365, replace=T) ,
  )
simulated_delay_data
#test
simulated_delay_data$date |> min() == "2023-01-01"
simulated_delay_data$date |> max() == "2023-12-31"
simulated_delay_data$delay_reason |> min() >= 1
simulated_delay_data$delay_reason |> max() <= 15
simulated_delay_data$delay_min |> min() >= 1
simulated_delay_data$delay_min |> max() <= 30
simulated_delay_data$line |> min() >= 1
simulated_delay_data$line |> max() <= 4
