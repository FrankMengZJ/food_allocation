#### Preamble ####
# Purpose: Cleans the raw delay data
# Author: Zijun Mneg
# Date: 24 January 2024
# Contact: zijun.meng@mai.utoronto.ca
# License: MIT
# Pre-requisites: -

#### Workspace setup ####
library(tidyverse)
#### Clean data ####
raw_data <- read_csv("inputs/data/raw_data.csv")


cleaned_data <-
  raw_data |>
  rename(Min_Delay = "Min Delay", Min_Gap = "Min Gap")|>
  select(Date, Time, Day, Station, Code, Min_Delay, Line) |>
  filter(Min_Delay > 0) %>% 
  group_by(Line)

cleaned_data <-
  cleaned_data[cleaned_data$Line %in% c("BD", "SHP", "SRT", "YU"), ]
cleaned_data
#### Save data ####
write_csv(cleaned_data, "outputs/data/analysis_data.csv")
