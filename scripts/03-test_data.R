#### Preamble ####
# Purpose: Test the data
# Author: Zijun Meng
# Date: 19 February 2024
# Contact: zijun.meng@mai.utoronto.ca
# License: MIT
# Pre-requisites: Run the data cleaning script
# download the data from https://www.journals.uchicago.edu/doi/suppl/10.1086/720332/suppl_file/2017061data.zip
# unzip the file, put bidding.csv file in the folder "inputs/data" 


library(ggplot2)
library(dplyr)

# Load and prepare the data
df <- read.csv('outputs/data/bidding.csv')

df$grossweight |> min() > 0

df$totalPounds |> min() > 0

df$month_num |> min() >= 1
df$month_num |> max() <= 12

df$year |> min() >= 2005

