#libraries
library(here)
library(tidyverse)
library(janitor)

#clean data (merge tables)
coverage_values <- read_csv(here("data","coverage_values.csv"))
parent_codes <- read_csv(here("data","parent_codes.csv"))
interview_id <- read_csv(here("data","interview_id.csv"))

colnames(parent_codes)[colnames(parent_codes) == "parent_code_name"] <- "clean_code"

parent_codes_new <- left_join(parent_codes, coverage_values, by = "clean_code")

master_parent_codes <-  left_join(parent_codes_new, interview_id, by = "interview_id")

write_csv(master_parent_codes, here("data", "master_parent_codes.csv"))
