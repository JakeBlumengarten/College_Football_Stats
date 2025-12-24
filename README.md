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

# Evaluating the Impact of Dual-Threat Quarterbacks on College Football Performance

This project analyzes how quarterback style—specifically the rise of the dual-threat quarterback—relates to individual performance in college football. Using game- and season-level data from FBS quarterbacks, I model passing QBR as a function of passing efficiency, rushing production, team context, and competition level. The goal is to determine whether quarterback mobility provides independent value beyond traditional passing statistics and team strength. Check it out here: http://rpubs.com/jakeblum54/1383724

## Methods
- Collected game-level player statistics using the cfbfastR package
- Aggregated game data to season-level quarterback performance
- Classified quarterbacks by style (dual-threat vs. non–dual-threat) using rushing and passing thresholds
- Applied forward-selection linear regression to model passing QBR
- Addressed multicollinearity using variance inflation factors (VIF)
- Identified influential observations using leverage, Cook’s Distance, DFFITS, and DFBETAS
- Evaluated model assumptions with residual diagnostics and influence plots

## Results

The final regression model shows that quarterback efficiency and decision-making dominate raw production in explaining QBR. Rushing efficiency and situational mobility are positively associated with performance, while high rushing volume is negatively associated, indicating diminishing returns. Dual-threat quarterback status remains a statistically significant predictor of QBR after controlling for passing metrics, team offensive success, and strength of schedule, suggesting quarterback style has an independent relationship with performance.

## Tools & Technologies
- R
- cfbfastR, dplyr, car, ggplot2, ggrepel
- Linear regression, model diagnostics, influence analysis

## Notes

This analysis focuses on FBS quarterbacks with meaningful playing time and should be interpreted as explanatory rather than causal. QBR is used as a summary performance metric and reflects both individual decision-making and team context.

## Author
Jake Blumengarten  
[LinkedIn](https://www.linkedin.com/in/jake-blumengarten)  
