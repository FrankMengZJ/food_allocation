#### Preamble ####
# Purpose: Reproduce figure 2
# Author: Zijun Mneg
# Date: 12 February 2024
# Contact: zijun.meng@mai.utoronto.ca
# License: MIT
# Pre-requisites: -

library(ggplot2)
library(dplyr)

# Load and prepare the data
df <- read.csv('inputs/data/bidding.csv') %>%
  mutate(unitprice = pmin(pmax(pricePerPound, -0.2), 1.5)) # Clamp values within [-0.2, 1.5] range directly

# Define the number of non-NA unitprice values for scaling y-axis labels
N <- sum(!is.na(df$unitprice))

# Create the histogram
ggplot(df, aes(x = unitprice)) +
  geom_histogram(binwidth = 0.05, fill = 'grey', color = 'black', size = 0.35, alpha = 0.75) +
  scale_x_continuous(breaks = c(0, 0.5, 1, 1.5), labels = c("0", "0.5", "1.0", "1.5+"), limits = c(-0.2, 1.5)) +
  labs(x = 'Shares per pound', y = 'Frequency', title = 'Distribution of Price per Pound')+
  theme_minimal()
  