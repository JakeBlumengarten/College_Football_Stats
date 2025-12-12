library(glmnet)
library(dplyr)
library(car)

# ============================================================
# 1. Base modeling dataset
# ============================================================

model_df <- season_stats %>%
  select(
    -X,
    -total_losses,
    -games,
    -conference_losses,
    -home_losses,
    -away_losses,
    -postseason_losses,
    -postseason_wins,
    -champion
  )

# ============================================================
# 2. LASSO (feature screening)
# ============================================================
model_df_temp <- model_df%>%
  select(-school, -season)

x_mat <- model.matrix(total_wins ~ . - conference, model_df_temp)[, -1]
y_vec <- model_df$total_wins

lasso_cv <- cv.glmnet(x_mat, y_vec, alpha = 1)

coef(lasso_cv, s = "lambda.min")


# ============================================================
# 3. Initial OLS model
# ============================================================

ols_full <- lm(
  total_wins ~
    points +
    rushing_yards +
    turnovers +
    off_drives +
    off_stuff_rate +
    off_total_opportunities +
    off_rushing_plays_rate +
    off_passing_plays_success_rate +
    points_allowed_pg +
    def_field_pos_avg_start +
    def_passing_downs_ppa +
    def_passing_plays_rate +
    def_passing_plays_ppa,
  data = model_df
)

summary(ols_full)
vif(ols_full)

# ============================================================
# 4. Backward selection
# ============================================================

ols_final <- step(ols_full, direction = "backward")

summary(ols_final)
vif(ols_final)

final_vars <- all.vars(formula(ols_final))

# ============================================================
# 5. Train / Test split
# ============================================================

set.seed(123)

n_obs <- nrow(model_df)
train_rows <- sample(seq_len(n_obs), size = floor(0.7 * n_obs))

train_df <- model_df[train_rows, ] %>%
  select(school, season, all_of(final_vars))

write.csv(train_df, file = "Data/train_df.csv")

test_df <- model_df[-train_rows, ] %>%
  select(school, season, all_of(final_vars))

# ============================================================
# 6. Fit final model on training data
# ============================================================

final_model <- update(ols_final, data = train_df)

summary(final_model)
saveRDS(final_model, file = "Models/wins_model.rds")

# ============================================================
# 7. Predict on test set
# ============================================================

test_df <- test_df %>%
  mutate(predicted_wins = predict(final_model, newdata = test_df))

# ============================================================
# 8. Evaluation table
# ============================================================

test_results <- test_df %>%
  select(school, season, total_wins, predicted_wins)

write.csv(test_results, "Data/test_results.csv", row.names = FALSE)

# ============================================================
# 9. Model performance
# ============================================================

rmse <- sqrt(mean((test_df$total_wins - test_df$predicted_wins)^2))

sst <- sum((test_df$total_wins - mean(test_df$total_wins))^2)
sse <- sum((test_df$total_wins - test_df$predicted_wins)^2)

r2_test <- 1 - sse / sst

rmse
r2_test

# ============================================================
# 10. Prediction plot
# ============================================================

plot(
  test_df$total_wins,
  test_df$predicted_wins,
  xlab = "Actual Wins",
  ylab = "Predicted Wins",
  main = "Test Dataset Predictions"
)

abline(0, 1, col = "red", lwd = 2)

plot(
  final_model$fitted.values,
  residuals(final_model),
  xlab = "Fitted Values",
  ylab = "Residuals",
  main = "Residuals vs Fitted (Training Data)"
)
abline(h = 0, col = "red", lwd = 2)
