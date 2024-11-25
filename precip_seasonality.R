library(terra)
library(here)

# Define the base folder where your precipitation files are stored
ppt_base_dir <- "/Volumes/4TB\ drive/precip" 
years <- 1990:2020
pptszn_stacks <- list()

# Loop through each year to load the 12 monthly rasters
for (i in 1:length(years)) {
  pptszn_year_folder <- file.path(ppt_base_dir, paste0(years[i], "ppt"))
  pptszn_files <- list.files(pptszn_year_folder, pattern = "ppt\\d{4}[A-Za-z]{3}\\.asc$", full.names = TRUE)
  pptszn_stacks[[i]] <- rast(pptszn_files)
}

# Stack all the raster stacks from each year (combine all years into one stack)
pptszn_all_years_stack <- do.call(c, pptszn_stacks)

# Calculate the mean and standard deviation for each pixel across all years
mean_ppt_path <- here("output_30yr_ppt_tif", "ppt_30_years_mean.tif")
mean_ppt_raster <- rast(mean_ppt_path)
pptszn_sd <- stdev(pptszn_all_years_stack)

# Calculate the Coefficient of Variation (CV) for each pixel
precip_cv_raster <- pptszn_sd / mean_ppt_raster * 100
pptszn_output_path <- here("output_30yr_ppt_season_tif", "ppt_30_years_seasonality.tif")
writeRaster(precip_cv_raster, pptszn_output_path, overwrite = TRUE)
