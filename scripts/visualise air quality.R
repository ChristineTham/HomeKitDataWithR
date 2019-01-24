# load packages ----
library(tidyverse)
library(here)
library(skimr)
library(hexbin)

# load data ----
air_quality <- read_csv(here("data", "air_quality.csv"))

# visualise data ----
air_quality %>%
  filter(air_quality < 10000) %>%
  ggplot(aes(x = date, y = air_quality, color = room)) +
  ggtitle("Air Quality by Day by Room") +
  geom_smooth() +
  geom_point(alpha = 0.02)

ggsave(here("output", "air_quality_day_room.png"))

air_quality %>%
  filter(year == 2018) %>%
  ggplot(aes(x = hour, y = air_quality, color = room)) +
  ggtitle("Air Quality by Hour across Months by Room") +
  geom_smooth() +
  geom_point(alpha = 0.02) +
  facet_wrap(~month)

ggsave(here("output", "air_quality_hour_month_room.png"))