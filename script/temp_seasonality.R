library(terra)
library(here)

min_temp_base_folder <- "/Volumes/4TB\ drive/min_temp_months"
max_temp_base_folder <- "/Volumes/4TB\ drive/max_temp_months"
months <- c("january", "february", "march", "april", "may", "june", 
            "july", "august", "september", "october", "november", "december")

monthly_avg_temps <- list()

#loop to calculate monthly averages 
for (month in months) {
  # List all min and max temp files for the current month
  min_temp_files <- list.files(file.path(min_temp_base_folder, paste0(month, "_tmin")), pattern = "\\.asc$", full.names = TRUE)
  max_temp_files <- list.files(file.path(max_temp_base_folder, paste0(month, "_tmax")), pattern = "\\.asc$", full.names = TRUE)
  min_temp_stack <- rast(min_temp_files)
  max_temp_stack <- rast(max_temp_files)
  monthly_avg <- (min_temp_stack + max_temp_stack) / 2
  monthly_avg_temps[[month]] <- mean(monthly_avg)
}

#from monthly averages, calculate standard deviation to get seasonality

all_months_avg_temp_stack <- rast(monthly_avg_temps)
temp_seasonality <- stdev(all_months_avg_temp_stack)
tempszn_output_path <- here("output_30yr_temp_season_tif", "temp_30_years_seasonality.tif")
writeRaster(temp_seasonality, tempszn_output_path, overwrite = TRUE)





