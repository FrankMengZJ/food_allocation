#### Preamble ####
# Purpose: Reproduce figure 4
# Author: Zijun Meng
# Date: 12 February 2024
# Contact: zijun.meng@mail.utoronto.ca
# License: MIT
# Pre-requisites: -


library(ggplot2)
library(dplyr)

df <- read.csv('outputs/data/bidding.csv')

df <- df %>%
  group_by(choicemember) %>%
  summarise(shares = sum(totalShares, na.rm = TRUE),
            pounds = sum(totalPounds, na.rm = TRUE)) %>%
  mutate(pricePerPound = shares / pounds,
         avgPounds = 1 / pricePerPound) %>%
  ungroup() 

df$avgPounds <- ifelse(df$avgPounds > 20, 20, df$avgPounds)

fig <- ggplot(df, aes(x = avgPounds)) +
  geom_histogram(binwidth = 1, fill = 'grey', color = 'black', alpha = 0.75) +
  scale_y_continuous(expand = c(0, 0), breaks = seq(0, 20, 5)) +
  coord_cartesian(ylim = c(0, 21)) +
  xlab('Pounds per Share') +
  scale_x_continuous(breaks = c(0, 5, 10, 15, 20), labels = c("0", "5", "10", "15", "20+")) +
  ylab('Number of Food Banks') 

fig
