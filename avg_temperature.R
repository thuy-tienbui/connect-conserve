library(terra)
library(here)

tmax_base_dir <- "/Volumes/4TB\ drive/max_temp" 
years <- 1990:2020
tmax_stacks <- list()
tmax_annual_averages <- list()

#Loop years
for (year in years) {tmax_year_folder <- file.path(tmax_base_dir, paste0(year, "tmax"))
tmax_files <- list.files(tmax_year_folder, pattern = "\\.asc$", full.names = TRUE)
tmax_stacks[[as.character(year)]] <- rast(tmax_files)
tmax_annual_averages[[as.character(year)]] <- mean(tmax_stacks[[as.character(year)]])
tmax_output_folder <- here("output_tmax_tif")
tmax_output_path <- here(tmax_output_folder, paste0("tmax_", year, "_mean.tif"))
writeRaster(tmax_annual_averages[[as.character(year)]], tmax_output_path, overwrite = TRUE)
}

#Average across years to get 30-year normal
tmax_tif_files <- list.files(tmax_output_folder, pattern = "tmax_\\d{4}_mean\\.tif$", full.names = TRUE)
tmax_years_stack <- rast(tmax_tif_files)
tmax_avg_30yr <- mean(tmax_years_stack)
tmax_output_mean_path <- here("output_30yr_tmax_tif", "tmax_30_years_mean.tif")
writeRaster(tmax_avg_30yr, tmax_output_mean_path, overwrite = TRUE)

tmin_base_dir <- "/Volumes/4TB\ drive/min_temp" 
years <- 1990:2020
tmin_stacks <- list()
tmin_annual_averages <- list()

#Loop years 
for (year in years) {tmin_year_folder <- file.path(tmin_base_dir, paste0(year, "tmin"))
tmin_files <- list.files(tmin_year_folder, pattern = "\\.asc$", full.names = TRUE)
tmin_stacks[[as.character(year)]] <- rast(tmin_files)
tmin_annual_averages[[as.character(year)]] <- mean(tmin_stacks[[as.character(year)]])
tmin_output_folder <- here("output_tmin_tif")
tmin_output_path <- here(tmin_output_folder, paste0("tmin_", year, "_mean.tif"))
writeRaster(tmin_annual_averages[[as.character(year)]], tmin_output_path, overwrite = TRUE)
}

#Average across years to get 30-year normal
tmin_tif_files <- list.files(tmin_output_folder, pattern = "tmin_\\d{4}_mean\\.tif$", full.names = TRUE)
tmin_years_stack <- rast(tmin_tif_files)
tmin_avg_30yr <- mean(tmin_years_stack)
tmin_output_mean_path <- here("output_30yr_tmin_tif", "tmin_30_years_mean.tif")
writeRaster(tmin_avg_30yr, tmin_output_mean_path, overwrite = TRUE)

#Average mean max and min to get mean temperature across all years
tmax_folder <- here("output_30yr_tmax_tif")
tmin_folder <- here("output_30yr_tmin_tif")
tmax_files <- list.files(tmax_folder, pattern = ".tif$", full.names = TRUE)
tmin_files <- list.files(tmin_folder, pattern = ".tif$", full.names = TRUE)
tmax_raster <- rast(tmax_files)
tmin_raster <- rast(tmin_files)
avg_temp_raster <- (tmax_raster + tmin_raster) / 2
output_path <- here("output_30yr_temp_tif", "temp_30_years_mean.tif")
writeRaster(avg_temp_raster, output_path, overwrite = TRUE)



