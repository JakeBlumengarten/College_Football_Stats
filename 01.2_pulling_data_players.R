library(cfbfastR)
library(cfbplotR)
library(dplyr)
library(tidyr)
library(purrr)

# Players
# --------------------------------------------------------------------------------------------------------------------------
passing <- bind_rows(
  cfbd_stats_season_player(year = 2019, team = "LSU", category = "passing") %>% filter(player == "Joe Burrow"),
  cfbd_stats_season_player(year = 2007, team = "Florida", category = "passing") %>% filter(player == "Tim Tebow"),
  cfbd_stats_season_player(year = 2012, team = "Texas A&M", category = "passing") %>% filter(player == "Johnny Manziel"),
  cfbd_stats_season_player(year = 2020, team = "Florida", category = "passing") %>% filter(player == "Kyle Trask"),
  cfbd_stats_season_player(year = 2020, team = "Alabama", category = "passing") %>% filter(player == "Mac Jones"),
  cfbd_stats_season_player(year = 2017, team = "Oklahoma", category = "passing") %>% filter(player == "Baker Mayfield"),
  cfbd_stats_season_player(year = 2018, team = "Oklahoma", category = "passing") %>% filter(player == "Kyler Murray"),
  cfbd_stats_season_player(year = 2016, team = "Louisville", category = "passing") %>% filter(player == "Lamar Jackson"),
  cfbd_stats_season_player(year = 2014, team = "Oregon", category = "passing") %>% filter(player == "Marcus Mariota"),
  cfbd_stats_season_player(year = 2023, team = "LSU", category = "passing") %>% filter(player == "Jayden Daniels"),
  cfbd_stats_season_player(year = 2023, team = "Michigan", category = "passing") %>% filter(player == "J.J. McCarthy")
) %>%
  select(
    year, team, conference, athlete_id, player, position,
    passing_completions, passing_att, passing_pct,
    passing_yds, passing_td, passing_int, passing_ypa
  )

rushing <- bind_rows(
  cfbd_stats_season_player(year = 2019, team = "LSU", category = "rushing") %>% filter(player == "Joe Burrow"),
  cfbd_stats_season_player(year = 2007, team = "Florida", category = "rushing") %>% filter(player == "Tim Tebow"),
  cfbd_stats_season_player(year = 2012, team = "Texas A&M", category = "rushing") %>% filter(player == "Johnny Manziel"),
  cfbd_stats_season_player(year = 2020, team = "Florida", category = "rushing") %>% filter(player == "Kyle Trask"),
  cfbd_stats_season_player(year = 2020, team = "Alabama", category = "rushing") %>% filter(player == "Mac Jones"),
  cfbd_stats_season_player(year = 2017, team = "Oklahoma", category = "rushing") %>% filter(player == "Baker Mayfield"),
  cfbd_stats_season_player(year = 2018, team = "Oklahoma", category = "rushing") %>% filter(player == "Kyler Murray"),
  cfbd_stats_season_player(year = 2016, team = "Louisville", category = "rushing") %>% filter(player == "Lamar Jackson"),
  cfbd_stats_season_player(year = 2014, team = "Oregon", category = "rushing") %>% filter(player == "Marcus Mariota"),
  cfbd_stats_season_player(year = 2023, team = "LSU", category = "rushing") %>% filter(player == "Jayden Daniels"),
  cfbd_stats_season_player(year = 2023, team = "Michigan", category = "rushing") %>% filter(player == "J.J. McCarthy")
) %>%
  select(
    athlete_id, rushing_car, rushing_yds, rushing_td, rushing_ypc, rushing_long
  )

players <- passing%>%
  left_join(rushing, by = "athlete_id")

write.csv(players, file = "Data/players.csv")
