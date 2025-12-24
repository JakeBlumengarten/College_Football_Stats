library(cfbfastR)
library(cfbplotR)
library(dplyr)
library(tidyr)
library(purrr)

# Players
# --------------------------------------------------------------------------------------------------------------------------
# passing <- bind_rows(
#   cfbd_stats_season_player(year = 2019, team = "LSU", category = "passing") %>% filter(player == "Joe Burrow"),
#   cfbd_stats_season_player(year = 2007, team = "Florida", category = "passing") %>% filter(player == "Tim Tebow"),
#   cfbd_stats_season_player(year = 2012, team = "Texas A&M", category = "passing") %>% filter(player == "Johnny Manziel"),
#   cfbd_stats_season_player(year = 2020, team = "Florida", category = "passing") %>% filter(player == "Kyle Trask"),
#   cfbd_stats_season_player(year = 2020, team = "Alabama", category = "passing") %>% filter(player == "Mac Jones"),
#   cfbd_stats_season_player(year = 2017, team = "Oklahoma", category = "passing") %>% filter(player == "Baker Mayfield"),
#   cfbd_stats_season_player(year = 2018, team = "Oklahoma", category = "passing") %>% filter(player == "Kyler Murray"),
#   cfbd_stats_season_player(year = 2016, team = "Louisville", category = "passing") %>% filter(player == "Lamar Jackson"),
#   cfbd_stats_season_player(year = 2014, team = "Oregon", category = "passing") %>% filter(player == "Marcus Mariota"),
#   cfbd_stats_season_player(year = 2023, team = "LSU", category = "passing") %>% filter(player == "Jayden Daniels"),
#   cfbd_stats_season_player(year = 2023, team = "Michigan", category = "passing") %>% filter(player == "J.J. McCarthy")
# ) %>%
#   select(
#     year, team, conference, athlete_id, player, position,
#     passing_completions, passing_att, passing_pct,
#     passing_yds, passing_td, passing_int, passing_ypa
#   )
# 
# rushing <- bind_rows(
#   cfbd_stats_season_player(year = 2019, team = "LSU", category = "rushing") %>% filter(player == "Joe Burrow"),
#   cfbd_stats_season_player(year = 2007, team = "Florida", category = "rushing") %>% filter(player == "Tim Tebow"),
#   cfbd_stats_season_player(year = 2012, team = "Texas A&M", category = "rushing") %>% filter(player == "Johnny Manziel"),
#   cfbd_stats_season_player(year = 2020, team = "Florida", category = "rushing") %>% filter(player == "Kyle Trask"),
#   cfbd_stats_season_player(year = 2020, team = "Alabama", category = "rushing") %>% filter(player == "Mac Jones"),
#   cfbd_stats_season_player(year = 2017, team = "Oklahoma", category = "rushing") %>% filter(player == "Baker Mayfield"),
#   cfbd_stats_season_player(year = 2018, team = "Oklahoma", category = "rushing") %>% filter(player == "Kyler Murray"),
#   cfbd_stats_season_player(year = 2016, team = "Louisville", category = "rushing") %>% filter(player == "Lamar Jackson"),
#   cfbd_stats_season_player(year = 2014, team = "Oregon", category = "rushing") %>% filter(player == "Marcus Mariota"),
#   cfbd_stats_season_player(year = 2023, team = "LSU", category = "rushing") %>% filter(player == "Jayden Daniels"),
#   cfbd_stats_season_player(year = 2023, team = "Michigan", category = "rushing") %>% filter(player == "J.J. McCarthy")
# ) %>%
#   select(
#     athlete_id, rushing_car, rushing_yds, rushing_td, rushing_ypc, rushing_long
#   )
# 
# players <- passing%>%
#   left_join(rushing, by = "athlete_id")
# 
# write.csv(players, file = "Data/players.csv")

# ------------------------------

# seasons <- 2004:2025
# 
# players_universe <- map_df(
#   seasons,
#   ~ cfbd_stats_season_player(year = .x) %>%
#     select(player, team, conference) %>%
#     distinct() %>%
#     mutate(season = .x)
# )
# 
# set.seed(428)
# 
# players_random <- players_universe %>%
#   slice_sample(n = 100)
# 
# players_rushing_stats <- map_df(
#   seasons,
#   ~ cfbd_stats_season_player(year = .x, category = "rushing")
# )
# 
# players_rushing_stats <- players_rushing_stats%>%
#   select(
#     year, player, conference, athlete_id, rushing_car, rushing_yds, rushing_td, rushing_ypc, rushing_long
#   )
# 
# players_passing_stats <- map_df(
#   seasons,
#   ~ cfbd_stats_season_player(year = .x, category = "passing")
# )%>%
#   select(
#     year, player, conference, athlete_id, position,
#     passing_completions, passing_att, passing_pct,
#     passing_yds, passing_td, passing_int, passing_ypa
#   )
# 
# players_passing_stats <- players_passing_stats%>%
#   filter(passing_att >= 200)
# 
# players <- players_passing_stats %>%
#   left_join(players_rushing_stats, by = c("player", "year"))

# write.csv(players, file = "Data/players_random_full.csv")
