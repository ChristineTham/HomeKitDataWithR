# load packages ----
library(tidyverse)
library(here)
library(skimr)
library(hexbin)

# load data ----
air_pressure <- read_csv(here("data", "air_pressure.csv"))

# visualise data ----
air_pressure %>%
  ggplot(aes(x = date, y = air_pressure)) +
  ggtitle("Air Pressure Hex Density by Day") +
  geom_hex()

ggsave(here("output", "air_pressure_day_hex.png"))
