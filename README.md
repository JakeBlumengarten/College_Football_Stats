# Identifying Elite College Football Teams Statistically

This project examines whether elite college football teams can be identified using season-level performance metrics rather than reputation or narrative. Using publicly available data from the `cfbfastR` package, I model total season wins as a function of offensive efficiency, defensive performance, and possession structure for teams from 2004–2025. You can see the full compelted project using this link: https://jakeblumengarten.shinyapps.io/predict_total_wins/.

## Methods
- Collected game-level and season-level data using `cfbfastR`
- Aggregated game data into season-level team statistics
- Performed feature selection using LASSO regression
- Addressed multicollinearity with variance inflation factors (VIF)
- Selected a final model using backward AIC-based selection
- Split data into training (70%) and testing (30%) sets
- Evaluated model assumptions using residual diagnostics, leverage, Cook’s Distance, and PRESS statistics

## Results
The final regression model demonstrates strong predictive stability and generalizes well to unseen seasons, with test-set prediction error under one win per season. Passing efficiency, points allowed per game, offensive drive volume, and scoring opportunities emerge as the strongest statistical indicators of elite team performance.

## Tools & Technologies
- R
- `cfbfastR`, `glmnet`, `dplyr`, `ggplot2`
- Linear regression, LASSO, model diagnostics

## Notes
This analysis focuses on historically elite and high-profile teams and should be interpreted as explanatory rather than population-wide inference.

## Author
Jake Blumengarten  
[LinkedIn](https://www.linkedin.com/in/jake-blumengarten)  
