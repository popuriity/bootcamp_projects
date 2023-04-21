#  import library
library(nycflights13)
library(dplyr)

data("flights")
#flights

# select only faa code and airport name
airports_name <- airports %>% select(faa, airport = name)

# join airlines' name and airports' name
flight_data <- flights %>% 
  left_join(airlines, by = "carrier") %>%
  rename(airlines = name) %>% 
  left_join(airports_name, by = c("origin" = "faa")) %>% 
  rename(origin_name = airport) %>% 
  left_join(airports_name, by = c("dest" = "faa")) %>% 
  rename(dest_name = airport)

# find NA in airport name

null_name_airport <- flight_data %>% 
  select(origin, dest, origin_name, dest_name) %>% 
  filter(is.na(dest_name))

unique(null_name_airport$dest)

# Since there are 4 faa code that their name are missing.
# fill faa code: "BQN" "SJU" "STT" "PSE"
## BQN as Rafael Hernández Airport
## SJU as Luis Muñoz Marín International Airport
## STT as Cyril E. King Airport
## PSE as Mercedita International Airport

flight_data <- flight_data %>% 
  mutate(dest_name_fill = 
           case_when(dest == "BQN" ~ "Rafael Hernández",
                     dest == "SJU" ~ "Luis Muñoz Marín Intl",
                     dest == "STT" ~ "Cyril E. King",
                     dest == "PSE" ~ "Mercedita Intl",
                     TRUE ~ dest_name))

# export dataframe to csv file
write.csv(flight_data, "flight_data.csv", row.names = F)
