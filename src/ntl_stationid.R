
lake = read_csv('data/lake.csv') |> 
  mutate(stationid = 'deep hole', 
         stationid_zone = 'littoral', 
         sampling_frequency = 'fortnightly',
         sid_comments = NA)

# load lakeid to waterbody name table
source('src/Functions/getLakeName.R')
lakeName = getLakeName()

hypoDO = lakeName |> mutate(hypo_oxygen = c('Y',
                                         'Y',
                                         'Y',
                                         'Y',
                                         'Y',
                                         'N',
                                         'Y',
                                         'N',
                                         'N',
                                         'Fish Lake',
                                         'no_h'))

stationid = lake |> left_join(hypoDO) |> 
  select( 
  waterbody_name, 
  stationid, 
  stationid_lat_decdeg = waterbody_lat_decdeg, 
  stationid_lon_decdeg = waterbody_lon_decdeg, 
  stationid_depth_m = max_depth_m, 
  stationid_year_start = yr_start_yyyy, 
  stationid_year_finish = yr_end_yyyy, 
  stationid_zone, 
  sampling_frequency, 
  hypo_oxygen, 
  sid_comments)

write_csv(lake, 'data/stationid.csv')
