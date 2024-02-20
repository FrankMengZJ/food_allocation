#### Preamble ####
# Purpose: Reproduce figure 3
# Author: Zijun Mneg
# Date: 12 February 2024
# Contact: zijun.meng@mai.utoronto.ca
# License: MIT
# Pre-requisites: -


library(ggplot2)
library(dplyr)
library(forcats)

# Assuming 'data/bidding.csv' is your dataset path
df <- read.csv('inputs/data/bidding.csv')

# Simplify by directly working with necessary transformations
df <- df %>%
  mutate(
    monthyear = factor(monthyear, levels = unique(monthyear)),
    type = factor(type, levels = c('Cereal', unique(type[type != 'Cereal']))), # Ensure 'Cereal' is the reference
    price = pricePerPound * totalPounds,
    resprice = residuals(lm(pricePerPound ~ monthyear, data = .)) # Calculate residuals in the pipeline
  )

# Model residuals by food type
model_res <- lm(resprice ~ type, data = df)
predicted_prices <- data.frame(type = levels(df$type)) %>%
  cbind(predict(model_res, newdata = ., interval = 'confidence'))

# Adjust predictions by adding the mean pricePerPound and normalizing
mean_price <- mean(df$pricePerPound, na.rm = TRUE)
predicted_prices <- within(predicted_prices, {
  fit <- fit + mean_price
  lwr <- lwr + mean_price
  upr <- upr + mean_price
  # Normalize based on the first fit value for comparison
  fit <- fit / fit[1] 
  lwr <- lwr / lwr[1]
  upr <- upr / upr[1]
})

# Ensure type is reordered for plotting based on the fit value
predicted_prices$type <- fct_reorder(predicted_prices$type, predicted_prices$fit)

# Plotting the estimated price per pound with corrected x-axis labels
ggplot(predicted_prices, aes(x = type, y = fit)) +
  geom_col() +
  coord_flip() +
  labs(x = "Food Type", y = "Normalized Estimated Price/Pound", title = "Estimated Price Per Pound by Food Type") +
  theme_minimal() # Use theme_minimal for simplicity

