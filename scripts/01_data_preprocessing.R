# Load required libraries
library(tidyverse)
library(readxl)
library(dplyr)

# Load data from Excel
retail_data <- read_excel("data/raw/OnlineRetail.xlsx")

# Preview first few rows
head(retail_data)
# Check column names
colnames(retail_data)
summary(retail_data)
unique(retail_data$Country)

# Remove rows with missing CustomerID
retail_data <- retail_data %>%
  filter(!is.na(CustomerID))

# Remove cancelled transactions (InvoiceNo starting with 'C')
retail_data <- retail_data %>%
  filter(!grepl("^C", InvoiceNo))

# Remove negative or zero quantity
retail_data <- retail_data %>%
  filter(Quantity > 0)

# (Optional) Clean whitespace in Description
retail_data$Description <- trimws(retail_data$Description)

# Preview first few rows
head(retail_data)
# Check column names
colnames(retail_data)
summary(retail_data)
unique(retail_data$Country)

# Save cleaned data for later use
write.csv(retail_data, "data/processed/cleaned_retail_data.csv", row.names = FALSE)

