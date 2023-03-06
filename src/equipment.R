# Equipment spreadsheet
# load lakeid to waterbody name table
source('src/Functions/getLakeName.R')
lakeName = getLakeName()

dfN = data.frame(
  temp_sensor_model = 'https://portal.edirepository.org/nis/mapbrowse?packageid=knb-lter-ntl.29.34', 
  chla_method = "https://portal.edirepository.org/nis/metadataviewer?packageid=knb-lter-ntl.35.31", 
  chla_sensor_model = NA, 
  ph_sensor_model = 'https://portal.edirepository.org/nis/mapbrowse?packageid=knb-lter-ntl.1.59', 
  cond_sensor_model = 'https://portal.edirepository.org/nis/mapbrowse?packageid=knb-lter-ntl.2.37', 
  TP_method = 'https://portal.edirepository.org/nis/mapbrowse?packageid=knb-lter-ntl.1.59', 
  dissolved_P_method = 'https://portal.edirepository.org/nis/mapbrowse?packageid=knb-lter-ntl.1.59', 
  NO2NO3_method = 'https://portal.edirepository.org/nis/mapbrowse?packageid=knb-lter-ntl.1.59', 
  TKN_method = NA, 
  DOC_method = 'https://portal.edirepository.org/nis/mapbrowse?packageid=knb-lter-ntl.1.59', 
  DIC_method = 'https://portal.edirepository.org/nis/mapbrowse?packageid=knb-lter-ntl.1.59', 
  silica_method = 'https://portal.edirepository.org/nis/mapbrowse?packageid=knb-lter-ntl.1.59', 
  chloride_method = 'https://portal.edirepository.org/nis/mapbrowse?packageid=knb-lter-ntl.2.37', 
  alkalinity_method = 'https://portal.edirepository.org/nis/mapbrowse?packageid=knb-lter-ntl.1.59', 
  hardness_method = NA, 
  turbidity_sensor = NA, 
  TN_method = 'https://portal.edirepository.org/nis/mapbrowse?packageid=knb-lter-ntl.1.59')

dfS = data.frame(
  temp_sensor_model = 'https://portal.edirepository.org/nis/mapbrowse?packageid=knb-lter-ntl.29.34', 
  chla_method = "https://portal.edirepository.org/nis/mapbrowse?packageid=knb-lter-ntl.38.28", 
  chla_sensor_model = NA, 
  ph_sensor_model = 'https://portal.edirepository.org/nis/mapbrowse?packageid=knb-lter-ntl.1.59', 
  cond_sensor_model = 'https://portal.edirepository.org/nis/mapbrowse?packageid=knb-lter-ntl.2.37', 
  TP_method = 'https://portal.edirepository.org/nis/mapbrowse?packageid=knb-lter-ntl.1.59', 
  dissolved_P_method = 'https://portal.edirepository.org/nis/mapbrowse?packageid=knb-lter-ntl.1.59', 
  NO2NO3_method = 'https://portal.edirepository.org/nis/mapbrowse?packageid=knb-lter-ntl.1.59', 
  TKN_method = 'https://portal.edirepository.org/nis/mapbrowse?packageid=knb-lter-ntl.1.59', 
  DOC_method = 'https://portal.edirepository.org/nis/mapbrowse?packageid=knb-lter-ntl.1.59', 
  DIC_method = 'https://portal.edirepository.org/nis/mapbrowse?packageid=knb-lter-ntl.1.59', 
  silica_method = 'https://portal.edirepository.org/nis/mapbrowse?packageid=knb-lter-ntl.1.59', 
  chloride_method = 'https://portal.edirepository.org/nis/mapbrowse?packageid=knb-lter-ntl.2.37', 
  alkalinity_method = 'https://portal.edirepository.org/nis/mapbrowse?packageid=knb-lter-ntl.1.59', 
  hardness_method = NA, 
  turbidity_sensor = NA, 
  TN_method = 'https://portal.edirepository.org/nis/mapbrowse?packageid=knb-lter-ntl.1.59')

equipment = lakeName |> bind_cols(rbind(dfN, dfN, dfN, dfN, dfN, dfN, dfN, dfS, dfS, dfS, dfS)) |> 
  select(-lakeid)

write_csv(equipment, 'data/equipment.csv')
