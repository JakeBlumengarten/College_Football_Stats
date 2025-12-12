library(cfbfastR)
library(cfbplotR)
library(dplyr)
library(tidyr)
library(purrr)

# Randomly Select 10 Teams Each Year Since 2004
# --------------------------------------------------------------------------------------------------------
teams_all <- read.csv("Data/download.csv")

teams_all <- teams_all %>%
  filter(!is.na(Conference)) %>%
  select(School, Conference)%>%
  filter(Conference %in% c("Big Ten", "ACC", "SEC"))

set.seed(123)

all_combinations <- expand.grid(
  school = teams_all$School,
  season = 2004:2025
)

teams_random <- all_combinations %>%
  slice_sample(n = 100)


games_list <- vector("list", nrow(teams_random))



# All Time Best Teams 
# --------------------------------------------------------------------------------------------------------

teams <- bind_rows(cfbd_game_team_stats(2008, team = "Florida") %>% filter(school == "Florida") %>% mutate(season = 2008, champion = TRUE),
                   cfbd_game_team_stats(2019, team = "LSU") %>% filter(school == "LSU") %>% mutate(season = 2019, champion = TRUE),
                   cfbd_game_team_stats(2024, team = "Ohio State") %>% filter(school == "Ohio State") %>% mutate(season = 2024, champion = TRUE),
                   cfbd_game_team_stats(2020, team = "Alabama") %>% filter(school == "Alabama") %>% mutate(season = 2020, champion = TRUE),
                   cfbd_game_team_stats(2005, team = "Texas") %>% filter(school == "Texas") %>% mutate(season = 2005, champion = FALSE),
                   cfbd_game_team_stats(2004, team = "USC") %>% filter(school == "USC") %>% mutate(season = 2004, champion = TRUE),
                   cfbd_game_team_stats(2022, team = "Georgia") %>% filter(school == "Georgia") %>% mutate(season = 2022, champion = TRUE),
                   cfbd_game_team_stats(2023, team = "Michigan") %>% filter(school == "Michigan") %>% mutate(season = 2023, champion = TRUE),
                   cfbd_game_team_stats(2012, team = "Texas A&M") %>% filter(school == "Texas A&M") %>% mutate(season = 2012, champion = FALSE),
                   cfbd_game_team_stats(2013, team = "Florida State") %>% filter(school == "Florida State") %>% mutate(season = 2013, champion = TRUE),
                   cfbd_game_team_stats(2006, team = "Florida") %>% filter(school == "Florida") %>% mutate(season = 2006, champion = TRUE),
                   cfbd_game_team_stats(2007, team = "Florida") %>% filter(school == "Florida") %>% mutate(season = 2007, champion = FALSE),
                   cfbd_game_team_stats(2009, team = "Nebraska") %>% filter(school == "Nebraska") %>% mutate(season = 2009, champion = FALSE),
                   cfbd_game_team_stats(2005, team = "USC") %>% filter(school == "USC") %>% mutate(season = 2005, champion = FALSE),
                   cfbd_game_team_stats(2018, team = "Clemson") %>% filter(school == "Clemson") %>% mutate(season = 2018, champion = TRUE),
                   cfbd_game_team_stats(2009, team = "Alabama") %>% filter(school == "Alabama") %>% mutate(season = 2009, champion = TRUE),
                   cfbd_game_team_stats(2010, team = "Auburn") %>% filter(school == "Auburn") %>% mutate(season = 2010, champion = TRUE),
                   cfbd_game_team_stats(2015, team = "Alabama") %>% filter(school == "Alabama") %>% mutate(season = 2015, champion = TRUE),
                   cfbd_game_team_stats(2011, team = "Alabama") %>% filter(school == "Alabama") %>% mutate(season = 2011, champion = TRUE),
                   cfbd_game_team_stats(2016, team = "Clemson") %>% filter(school == "Clemson") %>% mutate(season = 2016, champion = TRUE),
                   cfbd_game_team_stats(2016, team = "Alabama") %>% filter(school == "Alabama") %>% mutate(season = 2016, champion = FALSE),
                   cfbd_game_team_stats(2012, team = "Alabama") %>% filter(school == "Alabama") %>% mutate(season = 2012, champion = TRUE),
                   cfbd_game_team_stats(2018, team = "Alabama") %>% filter(school == "Alabama") %>% mutate(season = 2018, champion = FALSE),
                   cfbd_game_team_stats(2014, team = "Ohio State") %>% filter(school == "Ohio State") %>% mutate(season = 2014, champion = TRUE),
                   cfbd_game_team_stats(2009, team = "Florida") %>% filter(school == "Florida") %>% mutate(season = 2009, champion = FALSE),
                   cfbd_game_team_stats(2006, team = "Boise State") %>% filter(school == "Boise State") %>% mutate(season = 2006, champion = FALSE),
                   cfbd_game_team_stats(2024, team = "Boise State") %>% filter(school == "Boise State") %>% mutate(season = 2024, champion = FALSE),
                   cfbd_game_team_stats(2017, team = "Oklahoma") %>% filter(school == "Oklahoma") %>% mutate(season = 2017, champion = FALSE),
                   cfbd_game_team_stats(2018, team = "Oklahoma") %>% filter(school == "Oklahoma") %>% mutate(season = 2018, champion = FALSE),
                   cfbd_game_team_stats(2016, team = "Louisville") %>% filter(school == "Louisville") %>% mutate(season = 2016, champion = FALSE),
                   cfbd_game_team_stats(2014, team = "Oregon") %>% filter(school == "Oregon") %>% mutate(season = 2014, champion = FALSE),
                   cfbd_game_team_stats(2025, team = "Florida") %>% filter(school == "Florida") %>% mutate(season = 2025, champion = FALSE),
                   cfbd_game_team_stats(2025, team = "Ole Miss") %>% filter(school == "Ole Miss") %>% mutate(season = 2025, champion = FALSE),
                   cfbd_game_team_stats(2025, team = "Texas A&M") %>% filter(school == "Texas A&M") %>% mutate(season = 2025, champion = FALSE),
                   cfbd_game_team_stats(2025, team = "Oregon") %>% filter(school == "Oregon") %>% mutate(season = 2025, champion = FALSE),
                   cfbd_game_team_stats(2025, team = "Miami") %>% filter(school == "Miami") %>% mutate(season = 2025, champion = FALSE),
                   cfbd_game_team_stats(2024, team = "Miami") %>% filter(school == "Miami") %>% mutate(season = 2024, champion = FALSE),
                   cfbd_game_team_stats(2025, team = "Oklahoma") %>% filter(school == "Oklahoma") %>% mutate(season = 2025, champion = FALSE),
                   cfbd_game_team_stats(2025, team = "Alabama") %>% filter(school == "Alabama") %>% mutate(season = 2025, champion = FALSE),
                   cfbd_game_team_stats(2025, team = "Georgia") %>% filter(school == "Georgia") %>% mutate(season = 2025, champion = FALSE),
                   cfbd_game_team_stats(2025, team = "Indiana") %>% filter(school == "Indiana") %>% mutate(season = 2025, champion = FALSE),
                   cfbd_game_team_stats(2025, team = "Ohio State") %>% filter(school == "Ohio State") %>% mutate(season = 2025, champion = FALSE),
                   cfbd_game_team_stats(2025, team = "Texas Tech") %>% filter(school == "Texas Tech") %>% mutate(season = 2025, champion = FALSE),
                   cfbd_game_team_stats(2025, team = "Tulane") %>% filter(school == "Tulane") %>% mutate(season = 2025, champion = FALSE),
                   cfbd_game_team_stats(2025, team = "James Madison") %>% filter(school == "James Madison") %>% mutate(season = 2025, champion = FALSE),
                   cfbd_game_team_stats(2025, team = "Tennessee") %>% filter(school == "Tennessee") %>% mutate(season = 2025, champion = FALSE),
                   cfbd_game_team_stats(2025, team = "Vanderbilt") %>% filter(school == "Vanderbilt") %>% mutate(season = 2025, champion = FALSE),
                   cfbd_game_team_stats(2025, team = "Texas") %>% filter(school == "Texas") %>% mutate(season = 2025, champion = FALSE),
                   cfbd_game_team_stats(2020, team = "Florida") %>% filter(school == "Florida") %>% mutate(season = 2020, champion = FALSE)
                   )

write.csv(teams, file = "Data/raw_data.csv")


teams <- teams %>%
  separate(completion_attempts,
           into = c("completions", "attempts"),
           sep = "-", convert = TRUE) %>%
  separate(completion_attempts_allowed,
           into = c("completions_allowed", "attempts_allowed"),
           sep = "-", convert = TRUE) %>%
  separate(third_down_eff,
           into = c("third_down_conversions", "third_down_attempts"),
           sep = "-", convert = TRUE) %>%
  separate(third_down_eff_allowed,
           into = c("third_down_conversions_allowed",
                    "third_down_attempts_allowed"),
           sep = "-", convert = TRUE) %>%
  separate(total_penalties_yards,
           into = c("penalties", "penalty_yards"),
           sep = "-", convert = TRUE) %>%
  separate(total_penalties_yards_allowed,
           into = c("penalties_allowed", "penalty_yards_allowed"),
           sep = "-", convert = TRUE)

teams <- teams %>%
  mutate(
    across(
      c(
        points, points_allowed,
        total_yards, total_yards_allowed,
        net_passing_yards, net_passing_yards_allowed,
        rushing_yards, rushing_yards_allowed,
        rushing_attempts, rushing_attempts_allowed,
        passing_tds, passing_tds_allowed,
        rush_tds, rush_tds_allowed,
        interceptions, interceptions_allowed,
        turnovers, turnovers_allowed,
        first_downs, first_downs_allowed,
        completions, attempts,
        third_down_conversions, third_down_attempts,
        third_down_conversions_allowed,
        third_down_attempts_allowed
      ),
      as.numeric
    )
  )

teams <- teams %>%
  mutate(
    possession_seconds =
      as.numeric(sub(":(.*)", "", possession_time)) * 60 +
      as.numeric(sub("(.*):", "", possession_time)),
    
    possession_seconds_allowed =
      as.numeric(sub(":(.*)", "", possession_time_allowed)) * 60 +
      as.numeric(sub("(.*):", "", possession_time_allowed))
  )

season_stats <- teams %>%
  group_by(school, season) %>%
  summarise(
    champion = first(champion),
    
    # ------------------------
    # Scoring
    # ------------------------
    points = sum(points),
    points_allowed = sum(points_allowed),
    
    # ------------------------
    # Yardage
    # ------------------------
    total_yards = sum(total_yards),
    total_yards_allowed = sum(total_yards_allowed),
    
    passing_yards = sum(net_passing_yards),
    rushing_yards = sum(rushing_yards),
    
    # ------------------------
    # Efficiency
    # ------------------------
    completions = sum(completions),
    attempts = sum(attempts),
    completion_pct = completions / attempts,
    
    yards_per_pass = passing_yards / attempts,
    yards_per_rush =
      rushing_yards / sum(rushing_attempts),
    
    # ------------------------
    # Turnovers
    # ------------------------
    turnovers = sum(turnovers),
    interceptions_thrown = sum(interceptions),
    interceptions_made = sum(interceptions_allowed),
    
    # ------------------------
    # Situational
    # ------------------------
    first_downs = sum(first_downs),
    
    third_down_pct =
      sum(third_down_conversions) /
      sum(third_down_attempts),
    
    # ------------------------
    # Possession
    # ------------------------
    possession_minutes =
      sum(possession_seconds, na.rm = TRUE) / 60,
    
    games = n(),
    
    .groups = "drop"
  )

season_stats <- season_stats %>%
  mutate(
    total_yards_pg = total_yards / games,
    total_yards_allowed_pg = total_yards_allowed / games,
    points_pg = points / games,
    points_allowed_pg = points_allowed / games
  )

records <- season_stats %>%
  distinct(school, season) %>%
  rowwise() %>%
  mutate(
    rec = list(cfbd_game_records(season, school))
  ) %>%
  unnest(rec) %>%
  transmute(
    school = team,
    season = year,
    total_wins,
    total_losses,
    conference_losses,
    home_losses,
    away_losses,
    postseason_wins,
    postseason_losses
  )

season_stats <- season_stats %>%
  left_join(
    records,
    by = c("school", "season")
  )

teams_advanced <- bind_rows(
  
  cfbd_stats_season_advanced(2008, team = "Florida", excl_garbage_time= TRUE)        %>% mutate(season = 2008),
  cfbd_stats_season_advanced(2019, team = "LSU", excl_garbage_time= TRUE)            %>% mutate(season = 2019),
  cfbd_stats_season_advanced(2024, team = "Ohio State", excl_garbage_time= TRUE)     %>% mutate(season = 2024),
  cfbd_stats_season_advanced(2020, team = "Alabama", excl_garbage_time= TRUE)        %>% mutate(season = 2020),
  cfbd_stats_season_advanced(2005, team = "Texas", excl_garbage_time= TRUE)          %>% mutate(season = 2005),
  cfbd_stats_season_advanced(2004, team = "USC", excl_garbage_time= TRUE)            %>% mutate(season = 2004),
  cfbd_stats_season_advanced(2022, team = "Georgia", excl_garbage_time= TRUE)        %>% mutate(season = 2022),
  cfbd_stats_season_advanced(2023, team = "Michigan", excl_garbage_time= TRUE)       %>% mutate(season = 2023),
  cfbd_stats_season_advanced(2012, team = "Texas A&M", excl_garbage_time= TRUE)      %>% mutate(season = 2012),
  cfbd_stats_season_advanced(2013, team = "Florida State", excl_garbage_time= TRUE)  %>% mutate(season = 2013),
  
  cfbd_stats_season_advanced(2006, team = "Florida", excl_garbage_time= TRUE)        %>% mutate(season = 2006),
  cfbd_stats_season_advanced(2007, team = "Florida", excl_garbage_time= TRUE)        %>% mutate(season = 2007),
  cfbd_stats_season_advanced(2009, team = "Nebraska", excl_garbage_time= TRUE)       %>% mutate(season = 2009),
  cfbd_stats_season_advanced(2005, team = "USC", excl_garbage_time= TRUE)            %>% mutate(season = 2005),
  
  cfbd_stats_season_advanced(2018, team = "Clemson", excl_garbage_time= TRUE)        %>% mutate(season = 2018),
  cfbd_stats_season_advanced(2009, team = "Alabama", excl_garbage_time= TRUE)        %>% mutate(season = 2009),
  cfbd_stats_season_advanced(2010, team = "Auburn", excl_garbage_time= TRUE)         %>% mutate(season = 2010),
  cfbd_stats_season_advanced(2015, team = "Alabama", excl_garbage_time= TRUE)        %>% mutate(season = 2015),
  cfbd_stats_season_advanced(2011, team = "Alabama", excl_garbage_time= TRUE)        %>% mutate(season = 2011),
  
  cfbd_stats_season_advanced(2016, team = "Clemson", excl_garbage_time= TRUE)        %>% mutate(season = 2016),
  cfbd_stats_season_advanced(2016, team = "Alabama", excl_garbage_time= TRUE)        %>% mutate(season = 2016),
  cfbd_stats_season_advanced(2012, team = "Alabama", excl_garbage_time= TRUE)        %>% mutate(season = 2012),
  cfbd_stats_season_advanced(2018, team = "Alabama", excl_garbage_time= TRUE)        %>% mutate(season = 2018),
  cfbd_stats_season_advanced(2014, team = "Ohio State", excl_garbage_time= TRUE)     %>% mutate(season = 2014),
  
  cfbd_stats_season_advanced(2009, team = "Florida", excl_garbage_time= TRUE)        %>% mutate(season = 2009),
  cfbd_stats_season_advanced(2006, team = "Boise State", excl_garbage_time= TRUE)    %>% mutate(season = 2006),
  cfbd_stats_season_advanced(2024, team = "Boise State", excl_garbage_time= TRUE)    %>% mutate(season = 2024),
  
  cfbd_stats_season_advanced(2017, team = "Oklahoma", excl_garbage_time= TRUE)       %>% mutate(season = 2017),
  cfbd_stats_season_advanced(2018, team = "Oklahoma", excl_garbage_time= TRUE)       %>% mutate(season = 2018),
  cfbd_stats_season_advanced(2016, team = "Louisville", excl_garbage_time= TRUE)     %>% mutate(season = 2016),
  cfbd_stats_season_advanced(2014, team = "Oregon", excl_garbage_time= TRUE)         %>% mutate(season = 2014),
  
  cfbd_stats_season_advanced(2025, team = "Florida", excl_garbage_time= TRUE)        %>% mutate(season = 2025),
  cfbd_stats_season_advanced(2025, team = "Ole Miss", excl_garbage_time= TRUE)       %>% mutate(season = 2025),
  cfbd_stats_season_advanced(2025, team = "Texas A&M", excl_garbage_time= TRUE)      %>% mutate(season = 2025),
  cfbd_stats_season_advanced(2025, team = "Oregon", excl_garbage_time= TRUE)         %>% mutate(season = 2025),
  cfbd_stats_season_advanced(2025, team = "Miami", excl_garbage_time= TRUE)          %>% mutate(season = 2025),
  cfbd_stats_season_advanced(2024, team = "Miami", excl_garbage_time= TRUE)          %>% mutate(season = 2024),
  
  cfbd_stats_season_advanced(2025, team = "Oklahoma", excl_garbage_time= TRUE)       %>% mutate(season = 2025),
  cfbd_stats_season_advanced(2025, team = "Alabama", excl_garbage_time= TRUE)        %>% mutate(season = 2025),
  cfbd_stats_season_advanced(2025, team = "Georgia", excl_garbage_time= TRUE)        %>% mutate(season = 2025),
  cfbd_stats_season_advanced(2025, team = "Indiana", excl_garbage_time= TRUE)        %>% mutate(season = 2025),
  cfbd_stats_season_advanced(2025, team = "Ohio State", excl_garbage_time= TRUE)     %>% mutate(season = 2025),
  cfbd_stats_season_advanced(2025, team = "Texas Tech", excl_garbage_time= TRUE)     %>% mutate(season = 2025),
  cfbd_stats_season_advanced(2025, team = "Tulane", excl_garbage_time= TRUE)         %>% mutate(season = 2025),
  cfbd_stats_season_advanced(2025, team = "James Madison", excl_garbage_time= TRUE)  %>% mutate(season = 2025),
  cfbd_stats_season_advanced(2025, team = "Tennessee", excl_garbage_time= TRUE)      %>% mutate(season = 2025),
  cfbd_stats_season_advanced(2025, team = "Vanderbilt", excl_garbage_time= TRUE)     %>% mutate(season = 2025),
  cfbd_stats_season_advanced(2025, team = "Texas", excl_garbage_time= TRUE)          %>% mutate(season = 2025),
  cfbd_stats_season_advanced(2020, team = "Florida", excl_garbage_time= TRUE)          %>% mutate(season = 2020)
  
)

season_stats <- season_stats %>%
  left_join(
    teams_advanced,
    by = c("school" = "team", "season" = "season")
  )

seasons <- min(season_stats$season):max(season_stats$season)

talent <- purrr::map_df(
  seasons,
  ~ cfbd_team_talent(.x)
)

write.csv(season_stats, file = "Data/season_stats.csv")