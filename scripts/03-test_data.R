"Considering the analysis provided in the paper regarding the Choice System's impact on food bank 
operations and pricing strategies, a relevant robustness check could involve analyzing the data by 
excluding food banks that exhibit extreme bidding behaviors, such as those consistently involved in 
auctions with negative prices or those that consistently bid much higher than the average
(e.g., prices in the top 5% of all bids). This adjustment would help to assess whether the observed price 
variability and strategic choices in food type valuation and quality-quantity trade-offs are robust to the 
exclusion of potential outliers that might drive the extreme ends of the observed distributions. 
"


library(ggplot2)
library(dplyr)

# Load and prepare the data
df <- read.csv('inputs/data/bidding.csv')

# Exclude extreme bidding behaviors: top 5% bids and negative prices
top_5_percent_threshold <- quantile(df$pricePerPound, 0.95, na.rm = TRUE)
df_filtered <- df %>%
  filter(pricePerPound <= top_5_percent_threshold, pricePerPound >= -0.2) %>%
  mutate(unitprice = pricePerPound) # No need to clamp after filtering

# Define the number of non-NA unitprice values for scaling y-axis labels
N_filtered <- sum(!is.na(df_filtered$unitprice))

# Create the histogram for the filtered data
ggplot(df_filtered, aes(x = unitprice)) +
  geom_histogram(binwidth = 0.05, fill = 'grey', color = 'black', size = 0.35, alpha = 0.75) +
  scale_x_continuous(breaks = c(0, 0.5, 1, 1.5), labels = c("0", "0.5", "1.0", "1.5+"), limits = c(-0.2, 1.5)) +
  labs(x = 'Shares per pound', y = 'Frequency', title = 'Filtered Distribution of Price per Pound') +
  theme_minimal()

distinct(df,warehousecity)




"
To focus on the impact of the Choice System across different months, you can analyze and visualize 
how food bank preferences or benefits vary monthly. Assuming you have variables in your dataset 
indicating the month of each auction and the efficiency metrics (like pounds per share), 
you can create a graph showing the monthly variation. Here's how you might approach this with R:"
"这个我不自信"
#这个烂透了 别用
library(ggplot2)
library(dplyr)

# Assuming 'month_num' uniquely identifies months across years in your dataset
# and 'poundsPerShare' indicates the efficiency or benefits obtained by food banks

library(dplyr)
library(ggplot2)
library(lubridate)

# Ensure monthyear is in a date format for proper chronological ordering
df_filtered <- df %>%
  filter(COUNTRYCODE %in% c("USA", "CAN")) %>%
  mutate(monthyear = as.Date(paste0(monthyear, "01"), format = "%b%Y01"))

# Analyzing monthly trends by country
monthly_trends <- df_filtered %>%
  group_by(COUNTRYCODE, month = month(monthyear), year = year(monthyear)) %>%
  summarise(AveragePoundsPerShare = mean(poundsPerShare, na.rm = TRUE)) %>%
  ungroup() %>%
  mutate(YearMonth = paste(year, month, sep = "-")) %>%
  arrange(COUNTRYCODE, year, month)

# Plotting
ggplot(monthly_trends, aes(x = YearMonth, y = AveragePoundsPerShare, color = COUNTRYCODE)) +
  geom_line() +
  facet_wrap(~ COUNTRYCODE, scales = "free_x") +
  labs(x = "Month-Year", y = "Average Pounds Per Share", title = "Monthly Food Bank Selection Trends: USA vs Canada") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))





"This analysis can explore differences in operational efficiency, potentially measured by poundsPerShare, 
between food banks in the USA and Canada. Operational efficiency can reflect how effectively 
food banks manage their resources and distribute food under the Choice System."

library(dplyr)
library(ggplot2)

# Filter data for USA and Canada only
df_filtered <- df %>% 
  filter(COUNTRYCODE %in% c("USA", "CANADA")) 

# Calculate average operational efficiency by country
efficiency_by_country <- df_filtered %>%
  group_by(COUNTRYCODE) %>%
  summarise(AveragePoundsPerShare = mean(poundsPerShare, na.rm = TRUE))

# Plotting
ggplot(efficiency_by_country, aes(x = COUNTRYCODE, y = AveragePoundsPerShare, fill = COUNTRYCODE)) +
  geom_bar(stat = "identity") +
  labs(x = "Country", y = "Average Pounds Per Share", title = "Operational Efficiency: USA vs Canada") +
  theme_minimal()


"How does seasonality affect the bidding behavior and priorities of food banks within the Choice System?
Exploring seasonal patterns can reveal how food banks adjust their strategies in response to changes 
in food availability, demand fluctuations, or seasonal funding variations."

library(ggplot2)
library(dplyr)

df$Season <- case_when(
  df$month_num %in% c(12, 1, 2) ~ "Winter",
  df$month_num %in% c(3, 4, 5) ~ "Spring",
  df$month_num %in% c(6, 7, 8) ~ "Summer",
  df$month_num %in% c(9, 10, 11) ~ "Fall",
  TRUE ~ NA_character_
)

# Calculate average pounds per share for each season
seasonal_stats <- df %>%
  group_by(Season) %>%
  summarise(AveragePoundsPerShare = mean(poundsPerShare, na.rm = TRUE),
            TotalBids = n()) %>%
  ungroup()

# Plotting the seasonal variations in average pounds per share
ggplot(seasonal_stats, aes(x = Season, y = AveragePoundsPerShare, fill = Season)) +
  geom_bar(stat = "identity") +
  labs(title = "Seasonal Variation in Average Pounds Per Share",
       x = "Season",
       y = "Average Pounds Per Share") +
  theme_minimal()