#### Preamble ####
# Purpose: Tests... [...UPDATE THIS...]
# Author: Zijun Mneg
# Date: 24 January 2024
# Contact: zijun.meng@mai.utoronto.ca
# License: MIT
# Pre-requisites: -


#### Workspace setup ####
library(tidyverse)
library(dplyr)
library(here)

#### Test data ####
cleaned_data <-  read_csv(file=here("outputs/data/analysis_data.csv"))

cleaned_data$Date |> min() == "2023-01-01"
cleaned_data$Date |> max() == "2023-12-31"
cleaned_data$Min_Delay |> min() > 0

distinct(cleaned_data, Code)
delaybyline <-
  cleaned_data |>
  group_by(Line) %>%
  summarise(Mean_Delay = mean(Min_Delay),n = n()) |>
  filter(n > 100) |>
  arrange(-n)

filter(cleaned_data,Line=="77 SWANSEA")

test_data2 <-
  cleaned_data |>
  group_by(Station) %>%
  summarise(Mean_Delay = mean(Min_Delay),n = n()) |>
  filter(n > 100) |>
  arrange(-n)

delaybyreason <-
  cleaned_data %>%
  group_by(Code) %>%
  summarise(Mean_Delay = mean(Min_Delay),n = n()) %>%
  filter(n > 100) %>%
  arrange(-n)
sum(delaybyreason$n)

delaybyreason <-
  cleaned_data %>%
  group_by(Code) %>%
  summarise(Mean_Delay = mean(Min_Delay),n = n()) %>%
  arrange(-n)
sum(delaybyreason$n)

delaybyreason <-
  delaybyreason %>%
  group_by(Code)
delaybyreason

reasonnum <-
  select(delaybyreason,Code,n)
reasonnum

sum_of_sig <- sum(reasonnum$n[reasonnum$n > 400])
sum_of_sig

sum_of_all <- sum(reasonnum$n)
sum_of_all

reasonmean <-
  select(delaybyreason,Code,Mean_Delay)
reasonmean

ggplot(data=delaybyline, aes(x=Line, y=Mean_Delay)) +
  geom_bar(stat="identity")

ggplot(data=delaybyline, aes(x=Line, y=n)) +
  geom_bar(stat="identity")
table(delaybyreason$Code,delaybyreason$n)
pie(delaybyreason$n,labels = delaybyreason$Code)


delaybyreason <-
  cleaned_data %>%
  group_by(Code) %>%
  summarise(Mean_Delay = mean(Min_Delay),n = n()) %>%
  filter(n > 400) %>%
  arrange(-n)
ggplot(data=delaybyreason, aes(x=Code, y=n)) +
  geom_bar(stat="identity")
