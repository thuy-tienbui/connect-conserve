library(terra)
library(here)


#Read in files for 1990-2020
ppt_base_dir <- "/Volumes/4TB\ drive/precip" 
years <- 1990:2020
ppt_stacks <- list()
ppt_annual_averages <- list()

#Loop years for efficiency
for (year in years) {ppt_year_folder <- file.path(ppt_base_dir, paste0(year, "ppt"))
ppt_files <- list.files(ppt_year_folder, pattern = "\\.asc$", full.names = TRUE)
ppt_stacks[[as.character(year)]] <- rast(ppt_files)
ppt_annual_averages[[as.character(year)]] <- mean(ppt_stacks[[as.character(year)]])
ppt_output_folder <- here("output_ppt_tif")
ppt_output_path <- here(ppt_output_folder, paste0("ppt_", year, "_mean.tif"))
writeRaster(ppt_annual_averages[[as.character(year)]], ppt_output_path, overwrite = TRUE)
}

#Average across years to get 30-year normal
ppt_tif_files <- list.files(ppt_output_folder, pattern = "ppt_\\d{4}_mean\\.tif$", full.names = TRUE)
ppt_years_stack <- rast(ppt_tif_files)
ppt_avg_30yr <- mean(ppt_years_stack)
output_mean_path <- here("output_30yr_ppt_tif", "ppt_30_years_mean.tif")
writeRaster(ppt_avg_30yr, output_mean_path, overwrite = TRUE)




