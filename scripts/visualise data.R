# Load packages ----
library(tidyverse)
library(here)
library(skimr)
library(readxl)
library(lubridate)
library(hexbin)

# reading data ----
# read in backyard data
backyard_air_pressure <- read_excel("data/Backyard_Air_Pressure.xlsx", range = cell_rows(c(4,NA)))
backyard_humidity <- read_excel("data/Backyard_Humidity.xlsx", range = cell_rows(c(4,NA)))
backyard_temperature <- read_excel("data/Backyard_Temperature.xlsx", range = cell_rows(c(4,NA)))

# read in other temperature data
bedroom_temperature <- read_excel("data/Bedroom_Temperature.xlsx", range = cell_rows(c(4,NA)))
livingroom_temperature <- read_excel("data/Living_Room_Temperature.xlsx", range = cell_rows(c(4,NA)))

# exploring the data
View(backyard_air_pressure)
dim(backyard_air_pressure)
str(backyard_air_pressure)
glimpse(backyard_air_pressure)
head(backyard_air_pressure)
tail(backyard_air_pressure)
summary(backyard_air_pressure)
skim(backyard_air_pressure)

# template for data wrangling
backyard_air_pressure_cleaned <- backyard_air_pressure %>%
  rename(datestr = Date, airpressure = `Air Pressure (hPa)`) %>%
  mutate(date = ymd_hms(datestr), room = "Back Yard") %>%
  select(room, date, airpressure, datestr) %>%
  mutate(hour = hour(date), mday = mday(date), month = month(date), year=year(date))

# wrangle temperature ----

# wrangle temperature data
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

# exploring temperature ----

dim(temperature)
str(temperature)
glimpse(temperature)
head(temperature)
tail(temperature)
summary(temperature)
skim(temperature)

# plot temperature ----

temperature %>%
  ggplot(aes(x = date, y = temperature, color = room)) +
  geom_smooth() +
  geom_point(alpha = 0.01)

temperature %>%
  filter(year == 2018) %>%
  ggplot(aes(x = hour, y = temperature, color = room)) +
  geom_smooth() +
  geom_point(alpha = 0.02) +
  facet_wrap(~month)

temperature %>%
  ggplot(aes(x = date, y = temperature, color = room)) +
  geom_density2d()

temperature %>%
  filter(room == "Back Yard") %>%
  ggplot(aes(x = date, y = temperature)) +
  geom_hex()

temperature %>%
  filter(room == "Back Yard") %>%
  ggplot(aes(x = date, y = temperature)) +
  geom_count()

temperature %>%
  filter(year == 2018) %>%
  ggplot(aes(x = hour, y = temperature, color = room)) +
  geom_point(alpha = 0.02) +
  facet_wrap(~month)
