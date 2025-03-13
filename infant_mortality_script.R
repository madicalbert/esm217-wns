# Infant Mortality


infant_mortality <- read_csv(here("data", "infant_mortality", "infant_mortality.csv")) %>%   clean_names() %>% 
  mutate(death_rate = parse_number(death_rate)) %>% 
  mutate(GEOID = as.character(county_code)) 

wns_pest_infmort <- left_join(wns_pesticides, infant_mortality, by = "GEOID") %>% 
  drop_na(total_pesticides_kg) %>% 
  drop_na(wns_status)  %>% 
  mutate(pesticides_per_sqm = total_pesticides_kg/ALAND) %>% 
  drop_na(death_rate)

tm_shape(counties, bbox = bbox)+
  tm_polygons(col = "white")+
  tm_shape(wns_pest_infmort)+
  tm_polygons(fill = "death_rate",
              palette = "viridis",
              title = "Infant Mortality Rate")+
  tm_compass(position = c("left", "bottom"))+
  tm_scale_bar(position = c("left", "bottom"))+
  tm_layout(title = "Infant Mortality Rate by County",
            title.position = c("left", "bottom"),
            legend.position = c("right", "bottom"))
