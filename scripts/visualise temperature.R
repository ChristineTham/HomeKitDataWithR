# load packages ----
library(tidyverse)
library(here)
library(skimr)
library(hexbin)

# load data ----
temperature <- read_csv(here("data", "temperature.csv"))

# visualise data ----
temperature %>%
  ggplot(aes(x = date, y = temperature, color = room)) +
  ggtitle("Temperature by Day by Room") +
  geom_smooth() +
  geom_point(alpha = 0.02)

ggsave(here("output", "temperature_day_room.png"))

temperature %>%
  filter(year == 2018) %>%
  ggplot(aes(x = hour, y = temperature, color = room)) +
  ggtitle("Temperature by Hour across Months by Room") +
  geom_smooth() +
  geom_point(alpha = 0.02) +
  facet_wrap(~month)

ggsave(here("output", "temperature_hour_month_room.png"))