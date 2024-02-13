#### Preamble ####
# Purpose: Downloads and saves the data from opendatatoronto
# Author: Zijun Mneg
# Date: 24 January 2024
# Contact: zijun.meng@mai.utoronto.ca
# License: MIT
# Pre-requisites: -


#### Workspace setup ####
library(opendatatoronto)
library(tidyverse)
library(gitcreds)


#### Download data ####
# [...ADD CODE HERE TO DOWNLOAD...]

the_raw_data <- 
  list_package_resources("https://open.toronto.ca/dataset/ttc-subway-delay-data/") %>%
  filter(name == "ttc-subway-delay-data-2023" ) %>%
  get_resource()
the_raw_data


# [...UPDATE THIS...]
# change the_raw_data to whatever name you assigned when you downloaded it.
write_csv(the_raw_data, "inputs/data/raw_data.csv") 

         
