

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

locations = 
  data.frame(lakeid = 'AL', lat = 46.038, long = -89.621, avg_depth_m = 2.9, max_depth_m = 8, mixing_type = 'dimictic', waterbody_area_ha = 164.2, elevation_m = 493, watershed_area_ha = NA) |>  bind_rows(
  data.frame(lakeid = 'BM', lat = 46.021067, long = -89.611783, avg_depth_m = 7.5, max_depth_m = 21.3, mixing_type = 'dimictic', waterbody_area_ha = 363.4, elevation_m = 500, watershed_area_ha = 555.6)) |> bind_rows(
  data.frame(lakeid = 'CB', lat = 46.007583, long = -89.606183, avg_depth_m = 1.7, max_depth_m = 2.5, mixing_type = 'dimictic', waterbody_area_ha = 0.6, elevation_m = 501, watershed_area_ha = NA)) |> bind_rows(
  data.frame(lakeid = 'CR', lat = 46.00275, long = -89.612233, avg_depth_m = 11.4, max_depth_m = 20.4, mixing_type = 'dimictic', waterbody_area_ha = 37.5, elevation_m = 500, watershed_area_ha = NA)) |> bind_rows(
  data.frame(lakeid = 'SP', lat = 46.007733, long = -89.701183, avg_depth_m = 10.9, max_depth_m = 20, mixing_type = 'dimictic', waterbody_area_ha = 64, elevation_m = 495, watershed_area_ha = 237.4)) |> bind_rows(
  data.frame(lakeid = 'TB', lat = 46.04125, long = -89.686283, avg_depth_m = 5.6, max_depth_m = 7.9, mixing_type = 'dimictic', waterbody_area_ha = 	1.0, elevation_m = 495, watershed_area_ha = NA)) |> bind_rows(
  data.frame(lakeid = 'TR',	lat = 46.029267, long = -89.665017, avg_depth_m = 14.6, max_depth_m = 35.7, mixing_type = 'dimictic', waterbody_area_ha = 1565.1, elevation_m = 490, watershed_area_ha = NA)) |> bind_rows(
  data.frame(lakeid = 'ME', lat = 43.09885, long = -89.40545, avg_depth_m = 12.8, max_depth_m = 25.3, mixing_type = 'dimictic', waterbody_area_ha = 3961.2, elevation_m = 259, watershed_area_ha = 29175)) |> bind_rows(
  data.frame(lakeid = 'MO', lat = 43.06337, long = -89.36086, avg_depth_m = 8.2, max_depth_m = 22.5, mixing_type = 'dimictic', waterbody_area_ha = 1359.8, elevation_m = 254, watershed_area_ha = 24946)) |> bind_rows(
  data.frame(lakeid = 'WI', lat = 43.05258, long = -89.42499, avg_depth_m = 2.7, max_depth_m = 4, mixing_type = 'polymictic', waterbody_area_ha = 136.2, elevation_m = 254, watershed_area_ha = 1398)) |> bind_rows(
  data.frame(lakeid = 'FI', lat = 43.28733, long = -89.65173, avg_depth_m = 6.6, max_depth_m = 18.9, mixing_type = 'dimictic', waterbody_area_ha = 80.4, elevation_m = 259, watershed_area_ha = NA))

  
locations2 = 
  data.frame(lakeid = 'AL', trophic_state = 'mesotrophic',	dom_land_use = 'natural', human_impacts = 'none', human_impacts_other = NA, num_basins = 2, dom_planktivore = 'yellow perch' , dom_piscivore = 'walleye', invasive_species_list = 'Banded Mystery Snail, Purple Loosestrife, Rusty Crayfish') |> bind_rows(
  data.frame(lakeid = 'BM', trophic_state = 'oligotrophic',	dom_land_use = 'natural', human_impacts = 'none', human_impacts_other = NA, num_basins = 1, dom_planktivore = 'yellow perch, cisco', dom_piscivore = 'walleye, small mouth bass', invasive_species_list = 'Purple Loosestrife, Rusty Crayfish')) |> bind_rows(
  data.frame(lakeid = 'CB', trophic_state = 'dystrophic',	dom_land_use = 'natural', human_impacts = 'none', human_impacts_other = NA, num_basins = 1, dom_planktivore = 'mud minnow', dom_piscivore = NA, invasive_species_list = NA)) |> bind_rows(
  data.frame(lakeid = 'CR', trophic_state = 'oligotrophic',	dom_land_use = 'natural', human_impacts = 'none', human_impacts_other = NA, num_basins = 1, dom_planktivore = 'yellow perch', dom_piscivore = 'large yellow perch (age 4+)', invasive_species_list = 'Rainbow Smelt')) |> bind_rows(
  data.frame(lakeid = 'SP', trophic_state = 'oligotrophic',	dom_land_use = 'natural', human_impacts = 'none', human_impacts_other = NA, num_basins = 1, dom_planktivore = 'cisco', dom_piscivore = 'walleye, small mouth bass', invasive_species_list = 'Purple Loosestrife, Rainbow Smelt, Rusty Crayfish')) |> bind_rows(
  data.frame(lakeid = 'TB', trophic_state = 'dystrophic',	dom_land_use = 'natural', human_impacts = 'none', human_impacts_other = NA, num_basins = 1, dom_planktivore = 'mud minnow', dom_piscivore = NA, invasive_species_list = NA)) |> bind_rows(
  data.frame(lakeid = 'TR', trophic_state = 'oligotrophic',	dom_land_use = 'natural', human_impacts = 'none', human_impacts_other = NA, num_basins = 2, dom_planktivore = 'cisco', dom_piscivore = 'walleye', invasive_species_list = 'Banded Mystery Snail, Rusty Crayfish, Spiny Waterflea')) |> bind_rows(
  data.frame(lakeid = 'ME', trophic_state = 'eutrophic',	dom_land_use = 'agricultural', human_impacts = 'eutrophication', human_impacts_other = NA, num_basins = 1, dom_planktivore = 'bluegill', dom_piscivore = 'bass, musky, pike', invasive_species_list = 'zebra mussels, spiny water flea, carp')) |> bind_rows(
  data.frame(lakeid = 'MO', trophic_state = 'eutrophic',	dom_land_use = 'agricultural', human_impacts = 'eutrophication', human_impacts_other = NA, num_basins = 1, dom_planktivore = 'bluegill', dom_piscivore = 'bass, pike', invasive_species_list = 'zebra mussels, spiny water flea, carp')) |> bind_rows(
  data.frame(lakeid = 'WI', trophic_state = 'eutrophic',	dom_land_use = 'developed', human_impacts = 'eutrophication', human_impacts_other = NA, num_basins = 1, dom_planktivore = 'bluegill', dom_piscivore = 'bass, musky', invasive_species_list = 'carp')) |> bind_rows(
  data.frame(lakeid = 'FI', trophic_state = 'mesotrophic',	dom_land_use = 'agricultural', human_impacts = 'eutrophication', human_impacts_other = NA, num_basins = 1, dom_planktivore = 'bluegill', dom_piscivore = 'large mouth bass', invasive_species_list = 'carp')) 

datayears = dt1 |> group_by(lakeid) |> summarise(yr_start_yyyy = first(year4), yr_end_yyyy = last(year4)) |> 
  bind_rows(dt2 |> group_by(lakeid) |> summarise(yr_start_yyyy = first(year4), yr_end_yyyy = last(year4)))

lake = lakeName |> 
  left_join(datayears) |>
  left_join(locations) |> left_join(locations2) |> 
  mutate(waterbody_type = 'lake', country = 'USA') |> 
  mutate(data_provider = 'North Temperate Lakes LTER', contact = 'Hilary Dugan', email = 'hdugan@wisc.edu', 
         website = 'lter. limnology.wisc.edu', lake_comments = NA) |> 
  select(waterbody_name, 
        yr_start_yyyy, 
        yr_end_yyyy, 
        waterbody_type, 
        waterbody_lat_decdeg = lat, 
        waterbody_lon_decdeg = long, 
        country, 
        avg_depth_m, 
        max_depth_m, 
        mixing_type, 
        waterbody_area_ha, 
        watershed_area_ha, 
        elevation_m, 
        trophic_state, 
        dom_land_use, 
        human_impacts, 
        human_impacts_other, 
        num_basins, 
        dom_planktivore, 
        dom_piscivore, 
        invasive_species_list, 
        data_provider, 
        contact, 
        email, 
        website, 
        lake_comments)

lake 

write_csv(lake, 'data/lake.csv')
