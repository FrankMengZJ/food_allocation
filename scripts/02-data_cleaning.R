#### Preamble ####
# Purpose: Clean the data
# Author: Zijun Meng
# Date: 19 February 2024
# Contact: zijun.meng@mail.utoronto.ca
# License: MIT
# Pre-requisites: Download the data from https://www.journals.uchicago.edu/doi/suppl/10.1086/720332/suppl_file/2017061data.zip
# unzip the file, put bidding.csv file in the folder "inputs/data" 

#### Workspace setup ####
library(tidyverse)
#### Clean data ####
raw_data <- read_csv("inputs/data/bidding.csv")


cleaned_data <-
  select(raw_data, year,monthyear, COUNTRYCODE, biddate, biddertype, grossweight, totalPounds, month_num, totalShares, pricePerPound, yellowPounds, choicemember, poundsPerShare, type)
#### Save data ####
write_csv(cleaned_data, "outputs/data/bidding.csv") 
