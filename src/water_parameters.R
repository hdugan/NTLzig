#water paramter spreadsheet
# load lakeid to waterbody name table
source('src/Functions/getLakeName.R')
lakeName = getLakeName()

# devtools::install_github('hdugan/NTLlakeloads')
library(NTLlakeloads)
library(tidyverse)
library(lubridate)
# Load derived thermocline data
thermocline = read_csv('deriveddata/thermocline.csv')

# Load NTL data
dtTemp = loadLTERtemp() |> 
  group_by(lakeid) |> 
  filter(sta == min(sta)) |> 
  select(lakeid, year4, sampledate, depth, wtemp, o2) |> 
  filter(!is.na(wtemp)) |> 
  ungroup()

dtChlN = loadLTERchlorophyll.north() |> 
  group_by(lakeid) |> 
  filter(sta == min(sta)) |> 
  select(lakeid, year4, sampledate, depth, chlor) |> 
  filter(!is.na(chlor)) |> 
  ungroup()

dtChlS = loadLTERchlorophyll.south() |> 
  mutate(depth = 0) |> 
  select(lakeid, year4, sampledate, depth, tri_chl_spec) |> 
  rename(chlor = tri_chl_spec) |> 
  filter(!is.na(chlor))
             
dtNuts = loadLTERnutrients()

dtSecchi = loadLTERsecchi() |> 
  group_by(lakeid) |> 
  filter(sta == min(sta)) |> 
  select(lakeid, year4, sampledate, secnview) |> 
  filter(!is.na(secnview)) |> 
  group_by(lakeid, year4, sampledate) |> 
  summarise(secnview = mean(secnview)) |> 
  ungroup()

dtIons = loadLTERions() |> 
  group_by(lakeid) |> 
  filter(sta == min(sta)) |> 
  select(lakeid, year4, sampledate, depth, cl, cond) |> 
  filter(!is.na(cl)) |> 
  ungroup()

# Clean up nutrient data
dtNuts.long = dtNuts %>%
  group_by(lakeid) |> 
  filter(sta == min(sta)) |> 
  ungroup() |> 
  mutate(across(everything(), ~replace(., .<0 , NA))) %>%
  rename_all( ~ str_replace(., "_sloh", '.sloh')) %>%
  rename_all( ~ str_replace(., "_n", '.n')) %>%
  rename_at(vars(ph:drsif.sloh), ~ str_c("value_",.)) %>%
  rename_at(vars(flagdepth:flagdrsif.sloh), ~ str_c("error_",.)) %>%
  rename_all(~str_replace_all(.,"flag","")) %>%
  pivot_longer(-(lakeid:event), names_to = c('.value','item'), names_sep = '_') %>%
  filter(!is.na(value) & value>= 0) %>%
  # filter(!str_detect(error,'A|K|L|H|Q') | is.na(error)) %>%
  filter(!str_detect(error,'A|K|H') | is.na(error)) %>% #Removed L and Q
  dplyr::select(-error) %>% 
  mutate(value = case_when(str_detect(item, ".sloh") ~ value*1000, #change sloh from mg to µg
                           TRUE ~ value)) %>% 
  mutate(item = case_when(str_detect(item, ".sloh") ~  str_remove(item, ".sloh"),
                          TRUE ~ item)) |> 
  select(-daynum, sta, event) |> 
  group_by(lakeid, year4, sampledate, depth, rep, item) |>
  summarise(value = mean(value, na.rm = T)) |> 
  pivot_wider(names_from = item, values_from = value)

# Join chlorophyll data
dtChl = dtChlN |> bind_rows(dtChlS)

# Join datasets
join1 = dtTemp |> left_join(dtNuts.long) |> 
  left_join(dtChl) |>
  left_join(dtIons) |> 
  left_join(thermocline) |> 
  mutate(layer = case_when(depth <= thermdepth_m ~ 'epi',
                           depth > thermdepth_m ~ 'hypo',
                           is.na(thermdepth_m) ~ 'epi')) 
  
# Join and summarize by layer
join2 = join1 |> 
  group_by(lakeid, year4, sampledate, layer) |> 
  summarise_if(is.numeric, mean, na.rm = TRUE) |> 
  mutate_all(~ifelse(is.nan(.), NA, .)) |> 
  ungroup()
  
# select epi columns
joinEpi = join2 |> filter(layer == 'epi') |> 
  mutate(totnuf = totnuf/1000, no3no2 = no3no2/1000, kjdl.n = kjdl.n/1000) |> 
  mutate(hardness_mgL = NA, 
         turbidity_NTU = NA) |> 
  select(lakeid:layer,
         surface_ph = ph, 
         surface_chla_ug_l = chlor, 
         surface_tp_ug_l = totpuf,
         surface_temp_c = wtemp, 
         NO2NO3_mgL = no3no2, 
         silica_mgL = drsif, 
         dissolved_P_ugL = drp, 
         TKN_mgL = kjdl.n, 
         do_epi_mgL = o2, 
         conductivity_umho_cm = cond,  # umho... really? 
         DOC_mgL = doc, 
         DIC_mgL = dic, 
         chloride_mgL = cl, 
         alkalinity_mgL = alk, 
         TN_mgL = totnuf,
         hardness_mgL, 
         turbidity_NTU
         )

# select hypo columns
joinHypo = join2 |> filter(layer == 'hypo') |> 
  mutate(totnuf = totnuf/1000, no3no2 = no3no2/1000, kjdl.n = kjdl.n/1000) |> 
  mutate(hardness_mgL = NA, 
         turbidity_NTU = NA) |> 
  select(lakeid:layer,
         hypo_temp_c = wtemp,
         do_hypo_mgL = o2
  )

# Final join
join3 = joinEpi |> left_join(joinHypo) |> 
  left_join(thermocline) |> 
  left_join(dtSecchi) |> 
  left_join(lakeName) |> 
  mutate(stationid = 'deep hole',
         month_mm = month(sampledate),
        day_of_month_dd = format(as.Date(sampledate), "%d"),
        time_hhmm = NA, 
        time_of_day = 'day',
        surf_or_int = 'int')


# Final table
join4 = join3 |> select(
  waterbody_name, 
  stationid, 
  year_yyyy = year4, 
  month_mm, 
  day_of_month_dd, 
  time_hhmm, 
  time_of_day, 
  surface_ph , 
  surface_chla_ug_l, 
  surface_tp_ug_l, 
  secchi_depth_m = secnview, 
  surface_temp_c, 
  hypo_temp_c, 
  thermocline_depth = thermdepth_m, 
  NO2NO3_mgL, 
  silica_mgL, 
  dissolved_P_ugL, 
  TKN_mgL, 
  do_epi_mgL, 
  do_hypo_mgL, 
  conductivity_umho_cm,  # umho... really? 
  DOC_mgL, 
  DIC_mgL, 
  chloride_mgL, 
  alkalinity_mgL,
  hardness_mgL, 
  turbidity_NTU, 
  TN_mgL, 
  surf_or_int) 

write_csv(join4, 'data/water_parameters.csv')
