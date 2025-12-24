library(glmnet)
library(dplyr)
library(car)
library(purrr)

# ============================================================
# 1. Base modeling dataset
# ============================================================

teams_random_stats <- teams_random_stats%>%
  filter(team != "Idaho") 

model_df <- teams_random_stats %>%
  select(
    -total_losses,
    -games,
    -team,
    -conference.x,
    -season,
    -kick_return_yds,
    -kick_returns,
    -kick_return_TDs
  )%>%
  na.omit()


# ============================================================
# 2. LASSO (feature screening)
# ============================================================
y_vec <- model_df$total_wins

x_mat <- model.matrix(
  total_wins ~ .,
  data = model_df
)[, -1]  # drop intercept

lasso_cv <- cv.glmnet(x_mat, y_vec, alpha = 1)

coef(lasso_cv, s = "lambda.min")

# At 1-SE lambda (more conservative)
coef_1se <- coef(lasso_cv, s = "lambda.1se")

lasso_vars_1se <- rownames(coef_1se)[coef_1se[, 1] != 0]

model_df_lasso <- model_df %>%
  select(total_wins, all_of(lasso_vars_1se[-1]))%>% # drop intercept
  select(-def_passing_plays_total_ppa, -def_total_ppa)  # this was causing singularity

lasso_lm <- lm(
  total_wins ~ .,
  data = model_df_lasso
)

summary(lasso_lm)

vif(lasso_lm)

saveRDS(lasso_lm, file = "Models/random_sample.rds")

selected_vars <- names(coef(lasso_lm))[-1]

model_df <- teams_random_stats %>%
  select(total_wins, all_of(selected_vars))

write.csv(model_df, file = "Data/model_df_random.csv", row.names = FALSE)

# ============================================================
# Test Dataset
# ============================================================

set.seed(45)
seasons <- 2024
target_n <- 35  # total team-season rows

valid_teams <- map_df(
  seasons,
  ~ cfbd_stats_season_team(year = .x) %>%
    select(team, conference) %>%
    distinct() %>%
    mutate(season = .x)
)

n_confs <- valid_teams %>% distinct(conference) %>% nrow()
teams_per_conf <- floor(target_n / n_confs)

teams_random_test <- valid_teams %>%
  group_by(conference) %>%
  slice_sample(n = teams_per_conf) %>%
  ungroup()

# Basic stats
test <- map2_df(
  teams_random_test$season,
  teams_random_test$team,
  ~ cfbd_stats_season_team(year = .x, team = .y)
)%>%
  mutate(poss_pg = time_of_poss_total / games,
         pass_comps_pg = pass_comps / games,
         pass_att_pg = pass_atts / games,
         net_pass_yds_pg = net_pass_yds / games,
         pass_td_pg = pass_TDs / games,
         rush_att_pg = rush_atts / games,
         rush_yds_pg = rush_yds / games,
         rush_td_pg = rush_TDs / games,
         int_pg = interceptions / games,
         total_yds_pg = total_yds / games,
         fumbles_lost_pg = fumbles_lost / games,
         turnovers_pg = turnovers / games,
         first_downs_pg = first_downs / games,
         third_downs_pg = third_downs / games,
         third_down_conversions_pg = third_down_convs / games,
         fourth_down_conversions_pg = fourth_down_convs / games,
         penalties_pg = penalties / games)%>%
  select(team, season, any_of(selected_vars))%>%
  na.omit()

# Advanced stats
test_adv <- map2_df(
  teams_random_test$season,
  teams_random_test$team,
  ~ cfbd_stats_season_advanced(year = .x, team = .y)
)%>%
  select(team, season, any_of(selected_vars))%>%
  na.omit()

# Combine
test <- test %>%
  left_join(
    test_adv,
    by = c("team", "season")
  )

test <- test %>%
  mutate(predicted_wins = predict(lasso_lm, newdata = test))



records <- map2_df(
  test$season,
  test$team,
  ~ cfbd_game_records(year = .x, team = .y)
)%>%
  select(team, year, total_wins)

records <- records %>%
  rename(
    season = year
  )

test <- test %>%
  left_join(
    records,
    by = c("team", "season")
  )

write.csv(test, file = "Data/test_random.csv", row.names = FALSE)

# ============================================================
# Model performance
# ============================================================

rmse <- sqrt(mean((test$total_wins - test$predicted_wins)^2))

anova(lasso_lm)

summary(lasso_lm)$r.squared
summary(lasso_lm)$adj.r.squared
cor(test$total_wins, test$predicted_wins)^2

# ============================================================
# 10. Plots
# ============================================================

qqnorm(lasso_lm$residuals)

plot(
  test$total_wins,
  test$predicted_wins,
  xlab = "Actual Wins",
  ylab = "Predicted Wins",
  main = "Test Dataset Predictions"
)

abline(0, 1, col = "red", lwd = 2)

plot(
  lasso_lm$fitted.values,
  residuals(lasso_lm),
  xlab = "Fitted Values",
  ylab = "Residuals",
  main = "Residuals vs Fitted (Training Data)"
)
abline(h = 0, col = "red", lwd = 2)

hist(
  lasso_lm$residuals,
  main = "Histogram of Residuals (Training Data)",
  xlab = "Residuals"
)


