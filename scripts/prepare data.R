# Load packages ----
library(tidyverse)
library(readxl)
library(lubridate)
library(here)

# reading data ----

# read in air pressure data
backyard_air_pressure <- read_excel(here("source", "Backyard_Air_Pressure.xlsx"), range = cell_rows(c(4,NA)))

# read in temperature data ----
backyard_temperature <- read_excel(here("source", "Backyard_Temperature.xlsx"), range = cell_rows(c(4,NA)))
bedroom_temperature <- read_excel(here("source", "Bedroom_Temperature.xlsx"), range = cell_rows(c(4,NA)))
livingroom_temperature <- read_excel(here("source", "Living_Room_Temperature.xlsx"), range = cell_rows(c(4,NA)))

# read in humidity data ----
backyard_humidity <- read_excel(here("source", "Backyard_Humidity.xlsx"), range = cell_rows(c(4,NA)))
bedroom_humidity <- read_excel(here("source", "Bedroom_Humidity.xlsx"), range = cell_rows(c(4,NA)))
livingroom_humidity <- read_excel(here("source", "Living_Room_Humidity.xlsx"), range = cell_rows(c(4,NA)))

# read in air quality data ----
bedroom_air_quality <- read_excel(here("source", "Bedroom_Air_Quality.xlsx"), range = cell_rows(c(4,NA)))
livingroom_air_quality <- read_excel(here("source", "Living_Room_Air_Quality.xlsx"), range = cell_rows(c(4,NA)))

# read in contact data ----
front_door_contact <- read_excel(here("source", "Front_Door_Contact.xlsx"), range = cell_rows(c(4,NA)))
back_door_contact <- read_excel(here("source", "Back_Door_Contact.xlsx"), range = cell_rows(c(4,NA)))

# read in motion data ----
hallway_motion <- read_excel(here("source", "Hallway_Motion_Motion.xlsx"), range = cell_rows(c(4,NA)))

# wrangle air pressure data ----
backyard_air_pressure_cleaned <- backyard_air_pressure %>%
  rename(datestr = Date, air_pressure = `Air Pressure (hPa)`) %>%
  mutate(date = force_tz(ymd_hms(datestr), "Australia/Sydney"), room = "Back Yard") %>%
  select(room, date, air_pressure, datestr) %>%
  mutate(hour = hour(date), mday = mday(date), month = month(date), year=year(date))

write_csv(backyard_air_pressure_cleaned, here("data", "air_pressure.csv"))

# wrangle temperature ----
backyard_temperature_cleaned <- backyard_temperature %>%
  rename(datestr = Date, temperature = `Temperature (Celsius)`) %>%
  mutate(date = force_tz(ymd_hms(datestr), "Australia/Sydney"), room = "Back Yard") %>%
  select(room, date, temperature, datestr) %>%
  mutate(hour = hour(date), mday = mday(date), month = month(date), year=year(date))

bedroom_temperature_cleaned <- bedroom_temperature %>%
  rename(datestr = Date, temperature = `Temperature (Celsius)`) %>%
  mutate(date = force_tz(ymd_hms(datestr), "Australia/Sydney"), room = "Bed Room") %>%
  select(room, date, temperature, datestr) %>%
  mutate(hour = hour(date), mday = mday(date), month = month(date), year=year(date))

livingroom_temperature_cleaned <- livingroom_temperature %>%
  rename(datestr = Date, temperature = `Temperature (Celsius)`) %>%
  mutate(date = force_tz(ymd_hms(datestr), "Australia/Sydney"), room = "Living Room") %>%
  select(room, date, temperature, datestr) %>%
  mutate(hour = hour(date), mday = mday(date), month = month(date), year=year(date))

temperature <- rbind(backyard_temperature_cleaned, bedroom_temperature_cleaned, livingroom_temperature_cleaned)

write_csv(temperature, here("data", "temperature.csv"))

# wrangle humidity ----
backyard_humidity_cleaned <- backyard_humidity %>%
  rename(datestr = Date, humidity = `Humidity (%)`) %>%
  mutate(date = force_tz(ymd_hms(datestr), "Australia/Sydney"), room = "Back Yard") %>%
  select(room, date, humidity, datestr) %>%
  mutate(hour = hour(date), mday = mday(date), month = month(date), year=year(date))

bedroom_humidity_cleaned <- bedroom_humidity %>%
  rename(datestr = Date, humidity = `Humidity (%)`) %>%
  mutate(date = force_tz(ymd_hms(datestr), "Australia/Sydney"), room = "Bed Room") %>%
  select(room, date, humidity, datestr) %>%
  mutate(hour = hour(date), mday = mday(date), month = month(date), year=year(date))

livingroom_humidity_cleaned <- livingroom_humidity %>%
  rename(datestr = Date, humidity = `Humidity (%)`) %>%
  mutate(date = force_tz(ymd_hms(datestr), "Australia/Sydney"), room = "Living Room") %>%
  select(room, date, humidity, datestr) %>%
  mutate(hour = hour(date), mday = mday(date), month = month(date), year=year(date))

humidity <- rbind(backyard_humidity_cleaned, bedroom_humidity_cleaned, livingroom_humidity_cleaned)

write_csv(humidity, here("data", "humidity.csv"))

# wrangle air quality ----
bedroom_air_quality_cleaned <- bedroom_air_quality %>%
  rename(datestr = Date, air_quality = `Air Quality (ppm)`) %>%
  mutate(date = force_tz(ymd_hms(datestr), "Australia/Sydney"), room = "Bed Room") %>%
  select(room, date, air_quality, datestr) %>%
  mutate(hour = hour(date), mday = mday(date), month = month(date), year=year(date))

livingroom_air_quality_cleaned <- livingroom_air_quality %>%
  rename(datestr = Date, air_quality = `Air Quality (ppm)`) %>%
  mutate(date = force_tz(ymd_hms(datestr), "Australia/Sydney"), room = "Living Room") %>%
  select(room, date, air_quality, datestr) %>%
  mutate(hour = hour(date), mday = mday(date), month = month(date), year=year(date))

air_quality <- rbind(bedroom_air_quality_cleaned, livingroom_air_quality_cleaned)

write_csv(air_quality, here("data", "air_quality.csv"))

# wrangle contact ----
front_door_contact_cleaned <- front_door_contact %>%
  rename(datestr = Date, contact = Contact) %>%
  mutate(date = force_tz(ymd_hms(datestr), "Australia/Sydney"), room = "Front Door") %>%
  select(room, date, contact, datestr) %>%
  mutate(hour = hour(date), mday = mday(date), month = month(date), year=year(date))

back_door_contact_cleaned <- back_door_contact %>%
  rename(datestr = Date, contact = Contact) %>%
  mutate(date = force_tz(ymd_hms(datestr), "Australia/Sydney"), room = "Back Door") %>%
  select(room, date, contact, datestr) %>%
  mutate(hour = hour(date), mday = mday(date), month = month(date), year=year(date))

contact <- rbind(front_door_contact_cleaned, back_door_contact_cleaned)

write_csv(air_quality, here("data", "air_quality.csv"))

# wrangle motion data ----
hallway_motion_cleaned <- hallway_motion %>%
  rename(datestr = Date, motion = Motion) %>%
  mutate(date = force_tz(ymd_hms(datestr), "Australia/Sydney"), room = "Front Door") %>%
  select(room, date, motion, datestr) %>%
  mutate(hour = hour(date), mday = mday(date), month = month(date), year=year(date))

write_csv(hallway_motion_cleaned, here("data", "motion.csv"))