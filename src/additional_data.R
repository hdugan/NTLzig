
# load lakeid to waterbody name table
source('src/Functions/getLakeName.R')
additional_data = getLakeName() |> 
  mutate(fish_density_biomass = rep('abundance', 11),
         veligers = NA,
         mussel_counts_biomass = NA,
         ciliates = NA,
         phytoplankton_biomass = c(rep(NA,7), 'yes', 'yes', NA, NA),
         bacteria_biomass = NA,
         stratified_zoop = NA,
         detailed_zoop_length = NA,
         meterological = c('yes', 'yes', 'no', 'yes', 'no', 'yes', 'no', 'yes', 'no',  'no', 'no'))

write_csv(additional_data, 'data/additional_data.csv')