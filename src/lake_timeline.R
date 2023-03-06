# lake_timeline
# load lakeid to waterbody name table
source('src/Functions/getLakeName.R')
lakeName = getLakeName()

# find lakes and years 
yearsN = dt1 |> group_by(lakeid, year4) |> 
  summarise() |> 
  arrange(lakeid, year4)

yearsS = dt2 |> group_by(lakeid, year4) |> 
  summarise() |> 
  arrange(lakeid, year4)

lake_timeline = lakeName |> inner_join(yearsN |> bind_rows(yearsS)) |> 
  mutate(events = NA_character_) |> 
  mutate(events = if_else(year4 %in% c(2012,2013) & lakeid == 'CR', 'Crystal mix experiment', events)) |> 
  mutate(events = if_else(year4 %in% c(2008) & lakeid == 'WI', 'Carp removal', events)) |> 
  mutate(events = if_else(year4 %in% c(2001:2008) & lakeid == 'SP', 'Crayfish removal', events)) |> 
  select(waterbody_name, year = year4, events)

write_csv(lake_timeline, 'data/lake_timeline.csv')


