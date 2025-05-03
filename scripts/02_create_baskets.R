library(dplyr)
library(arules)

# Load cleaned data
retail_data <- read.csv("data/processed/cleaned_retail_data.csv", stringsAsFactors = FALSE)

top_countries <- retail_data %>%
  count(Country, sort = TRUE) %>%
  slice(1:3) %>%
  pull(Country)

print(top_countries)

for (country in top_countries) {
  message("Processing transactions for: ", country)

  # Filter data for the country
  country_data <- retail_data %>%
    filter(Country == country)

  # Create a list: items grouped by InvoiceNo
  basket_list <- split(country_data$Description, country_data$InvoiceNo)

  # Convert to transaction class
  transactions <- as(basket_list, "transactions")

  # Save transactions to RDS file
  saveRDS(transactions, paste0("data/processed/transactions_", gsub(" ", "_", country), ".rds"))

  # Print a summary
  summary(transactions)
}



