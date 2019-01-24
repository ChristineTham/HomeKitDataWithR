# load packages ----
library(tidyverse)
library(here)
library(skimr)
library(hexbin)

# load data ----
humidity <- read_csv(here("data", "humidity.csv"))

# visualise data ----
humidity %>%
  ggplot(aes(x = date, y = humidity, color = room)) +
  ggtitle("Humidity Density by Day and Room") +
  geom_density_2d()

ggsave(here("output", "humidity_day_room_density.png"))
