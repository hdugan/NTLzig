library(tidyverse)
library(lubridate)


lakeName = data.frame(lakeid = c('TR', 'CR', 'BM', 'SP', 'AL', 'TB', 'CB', 'ME', 'MO', 'FI', 'WI'),
                      waterbody_name = c('Trout Lake',
                                         'Crystal Lake',
                                         'Big Muskellunge Lake',
                                         'Sparkling Lake',
                                         'Allequash',
                                         'Trout Bog',
                                         'Crystal Bog',
                                         'Lake Mendota',
                                         'Lake Monona',
                                         'Fish Lake',
                                         'Lake Wingra'))

### Download zooplankton data from EDI

# Package ID: knb-lter-ntl.37.37 Cataloging System:https://pasta.edirepository.org.
# Data set title: North Temperate Lakes LTER: Zooplankton - Trout Lake Area 1982 - current.
# A minimum of 5 samples per lake-year are identified and counted. 
maxDepths = data.frame(lakeid = c('TR', 'CB', 'BM', 'SP', 'AL', 'TB', 'CB'),
                       maxDepth = c(31, 18, 18, 17, 6, 6, 1))

# Samples are collected as a vertical tow using an 80-micron mesh conical net with a 30-cm diameter opening (net mouth: net length ratio = 1:3) 
# numberPerMeterSquared
inUrl1  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-ntl/37/37/c4b652eea76cd431ac5fd3562b1837ee" 
infile1 <- tempfile()
download.file(inUrl1,infile1,method="auto")
dt1 <-read_csv(infile1)

zoop.north = dt1 |> filter(station == 1) |> 
  left_join(lakeName) |> 
  left_join(maxDepths) |> 
  mutate(day_of_month_dd = format(as.Date(sample_date), "%d"),
         stationid = 'DeepHole',
         month_mm = month(sample_date),
         time_hhmm = NA,
         time_of_day = 'day', 
         sample_depth_m = maxDepth,
         zoop_sampler_type = 'vertical net', 
         zoop_mesh_um = 80, 
         zoop_net_mouth_area_cm2 = 30,
         min_counts	= NA,
         density_value = density,
         density_units = 'individuals per m2',
         biomass_value = NA,
         biomass_dry_wet = NA,	
         biomass_units = NA,
         time_zone = 'CT',
         ) |> 
  select(waterbody_name, stationid, year_yyyy = year4, month_mm, day_of_month_dd,
         time_hhmm, time_of_day, taxa_name = species_name, sample_depth_m,
         zoop_sampler_type, zoop_mesh_um, 
         zoop_net_mouth_area_cm2, min_counts, density_value, density_units, biomass_value,
         biomass_dry_wet, biomass_units, time_zone)
              
# Package ID: knb-lter-ntl.90.33 Cataloging System:https://pasta.edirepository.org.
# Data set title: North Temperate Lakes LTER: Zooplankton - Madison Lakes Area 1997 - current.

# Metadata
# Samples are collected as a vertical tow using an 80-micron mesh conical net with a 30-cm diameter opening (net mouth: net length ratio = 1:3) 
# Zooplankton tows are taken in the deep hole region of each lake at the same time and location as other limnological sampling; zooplankton samples are preserved in 70% ethanol for later processing.
# Crustacean species are identified and counted for Mendota and Monona and body lengths are recorded for a portion of each species identified 
# Numerical densities for Mendota and Monona zooplankton samples are reported in the database as number or organisms per square meter without correcting for net efficiency.
inUrl1  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-ntl/90/33/5880c7ba184589e239aec9c55f9d313b" 
infile1 <- tempfile()
download.file(inUrl1,infile1,method="auto")
dt2 <-read_csv(infile1)

zoop.south = dt2 |> filter(station == 1) |> 
  left_join(lakeName) |> 
  mutate(day_of_month_dd = format(as.Date(sample_date), "%d"),
         stationid = 'DeepHole',
         month_mm = month(sample_date),
         time_hhmm = NA,
         time_of_day = 'day', 
         sample_depth_m = towdepth,
         zoop_sampler_type = 'vertical net', 
         zoop_mesh_um = 80, 
         zoop_net_mouth_area_cm2 = 30,
         min_counts	= NA,
         density_value = density,
         density_units = 'individuals per m2',
         biomass_value = NA,
         biomass_dry_wet = NA,	
         biomass_units = NA,
         time_zone = 'CT',
  ) |> 
  select(waterbody_name, stationid, year_yyyy = year4, month_mm, day_of_month_dd,
         time_hhmm, time_of_day, taxa_name = species_name, sample_depth_m,
         zoop_sampler_type, zoop_mesh_um, 
         zoop_net_mouth_area_cm2, min_counts, density_value, density_units, biomass_value,
         biomass_dry_wet, biomass_units, time_zone)

# Bind dataframes
zooplankton = zoop.north |> bind_rows(zoop.south)
write_csv(zooplankton, 'data/zooplankton.csv')

################ Length data ################ 
length.north = dt1 |> 
  filter(station == 1) |> 
  filter(!is.na(avg_length)) |> 
  left_join(lakeName) |> 
  left_join(maxDepths) |> 
  mutate(day_of_month_dd = format(as.Date(sample_date), "%d"),
         stationid = 'DeepHole',
         month_mm = month(sample_date),
         time_hhmm = NA,
         time_of_day = 'day', 
         zoop_sampler_type = 'vertical net', 
         length_type = 'mean',
  ) |> 
  select(waterbody_name, stationid, year_yyyy = year4, month_mm, day_of_month_dd,
         time_hhmm, time_of_day, taxa_name = species_name, 
         zoop_sampler_type, 
         length_type, length_raw_ID = individuals_measured, length_mm = avg_length)


length.south = dt2 |> 
  filter(station == 1) |> 
  filter(!is.na(avg_length)) |> 
  left_join(lakeName) |> 
  mutate(day_of_month_dd = format(as.Date(sample_date), "%d"),
         stationid = 'DeepHole',
         month_mm = month(sample_date),
         time_hhmm = NA,
         time_of_day = 'day', 
         zoop_sampler_type = 'vertical net', 
         length_type = 'mean',
  ) |> 
  select(waterbody_name, stationid, year_yyyy = year4, month_mm, day_of_month_dd,
         time_hhmm, time_of_day, taxa_name = species_name, 
         zoop_sampler_type, 
         length_type, length_raw_ID = individuals_measured, length_mm = avg_length)

# Bind dataframes
zooplankton = zoop.north |> bind_rows(zoop.south)
write_csv(zooplankton, 'data/zoop_length.csv')




