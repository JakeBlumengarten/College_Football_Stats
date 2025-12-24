# College Football Statistical Analysis (2004–2025)

A comprehensive statistical analysis project using 20+ years of college football data to determine whether elite teams can be identified through performance metrics, and to evaluate the impact of dual-threat quarterbacks on team success.

[![R](https://img.shields.io/badge/R-4.0%2B-blue)](https://www.r-project.org/)
[![cfbfastR](https://img.shields.io/badge/cfbfastR-latest-green)](https://cfbfastR.sportsdataverse.org/)

## 📄 Interactive Reports

- 📊 [**Elite Teams Analysis Report**](https://jakeblumengarten.shinyapps.io/predict_total_wins/) - Main analysis with interactive plots
- 🔄 [**Random Sample Validation Report**](https://jakeblumengarten.shinyapps.io/team_report_random/) - Out-of-sample validation
- 🏈 [**Dual-Threat Quarterback Analysis**](https://rpubs.com/jakeblum54/1383724) - QB style evolution study

> **Note**: Reports are best viewed via [HTML Preview](https://htmlpreview.github.io/) for full interactivity.  Alternatively, download the HTML files and open them locally in your browser.

## 📊 Project Overview

This repository contains two major analytical components:

### 1. **Identifying Elite Teams Statistically**
Can we predict a team's total wins using only statistical performance metrics?  This analysis uses regression modeling and out-of-sample validation to examine how offensive efficiency, defensive performance, and possession structure relate to season success.

### 2. **Dual-Threat Quarterback Analysis**
How has the rise of mobile, dual-threat quarterbacks changed college football? This study classifies quarterbacks by style and analyzes their statistical impact on passing efficiency (QBR).

## 🎯 Key Findings

### Elite Teams Model
- **Predictive Accuracy**: Test-set RMSE < 1 win per season
- **Key Predictors**:  
  - Offensive efficiency (rushing yards, stuff rate, passing success rate)
  - Defensive performance (points allowed per game, field position)
  - Possession metrics (total drives, scoring opportunities)
- **Model Performance**: R² > 0.85 on training data, strong generalization to test set

### Dual-Threat Quarterbacks
- **Classification**: QBs categorized by rushing/passing thresholds
- **Impact**:  Rushing efficiency and mobility positively associated with QBR
- **Era Analysis**: Documented evolution from traditional pocket passers to modern dual-threats

## 📁 Repository Structure

```
College_Football_Stats/
├── Data/                              # Processed datasets
│   ├── season_stats.csv              # Aggregated season-level team data
│   ├── raw_data. csv                  # Game-level team statistics
│   ├── train_df.csv                  # Training dataset (70% split)
│   ├── test_results. csv              # Test predictions and actuals
│   ├── teams_random_stats.csv        # Random sample for validation
│   └── model_df_random.csv           # Random sample model data
├── Models/                            # Trained regression models
│   ├── wins_model.rds                # Final wins prediction model
│   └── random_sample.rds             # Random sample model
├── Plots/                             # Generated visualizations
│   ├── rushing_yards.png             # Rushing vs wins
│   ├── turnovers.png                 # Turnovers vs wins
│   ├── yards_for_vs_yards_allowed_per_game. png
│   ├── player_plots/                 # QB performance visualizations
│   └── random_sample/                # Validation plots
├── 01.1_pulling_data_teams. R         # Team data collection
├── 01.2_pulling_data_players.R       # Player data collection
├── 02_model_building.R               # Primary model development
├── 02.2_model_building_random. R      # Validation on random sample
├── 03_plots. R                        # Team visualization generation
├── 03.2_plots_nonmodel.R             # Exploratory plots
├── 03.3_plots_random.R               # Random sample plots
├── 03.4_plots_players.R              # Player visualization generation
├── team_report.Rmd                   # Elite teams analysis report
├── team_report. html                  # 📊 Elite teams HTML output
├── team_report_random.Rmd            # Random sample validation report
├── dual_threats.Rmd                  # Dual-threat QB analysis report
└── dual_threats.html                 # 🏈 Dual-threat QB HTML output
```

## 🛠️ Technology Stack

**R (1.1%)**
- `cfbfastR` - College football data API
- `cfbplotR` - Team logos and visualizations
- `glmnet` - LASSO regression for feature selection
- `car` - Variance inflation factor (VIF) analysis
- `dplyr` / `tidyr` - Data manipulation
- `ggplot2` / `ggrepel` - Data visualization
- `gt` / `kableExtra` - Table formatting
- `DT` - Interactive data tables

**RMarkdown & HTML (98.9%)**
- Interactive HTML reports with embedded visualizations
- Shiny integration for dynamic plot selection
- Responsive tables and diagnostic outputs

## 🚀 Getting Started

### Prerequisites

```r
# Install required packages
install. packages(c(
  "cfbfastR",
  "cfbplotR",
  "dplyr",
  "tidyr",
  "purrr",
  "glmnet",
  "car",
  "ggplot2",
  "ggrepel",
  "gt",
  "kableExtra",
  "DT",
  "broom",
  "shiny"
))
```

### Running the Analysis

#### 1. Data Collection
```r
# Pull team-level statistics (2004-2025)
source("01.1_pulling_data_teams.R")

# Pull player-level statistics (specific QBs)
source("01.2_pulling_data_players.R")
```

#### 2. Model Building
```r
# Build primary wins prediction model
source("02_model_building.R")

# Build validation model on random sample
source("02.2_model_building_random.R")
```

#### 3. Generate Visualizations
```r
# Team performance plots
source("03_plots.R")

# Non-model exploratory plots
source("03.2_plots_nonmodel.R")

# Random sample validation plots
source("03.3_plots_random.R")

# Player performance plots
source("03.4_plots_players.R")
```

#### 4. View Interactive Reports
```r
# Elite teams analysis (interactive HTML)
rmarkdown::render("team_report.Rmd")

# Random sample validation
rmarkdown::render("team_report_random.Rmd")

# Dual-threat QB analysis
rmarkdown::render("dual_threats.Rmd")
```

**Or view pre-rendered reports:**
- [Elite Teams Report (HTML Preview)](https://htmlpreview.github.io/?https://github.com/JakeBlumengarten/College_Football_Stats/blob/main/team_report.html)
- [Dual-Threat QB Report (HTML Preview)](https://htmlpreview.github.io/?https://github.com/JakeBlumengarten/College_Football_Stats/blob/main/dual_threats.html)

## 📈 Methodology

### Elite Teams Model Pipeline

1. **Data Collection**:  
   - Gathered game-level data for historically elite teams (2004–2025)
   - Included random sample of teams across all conferences for validation

2. **Feature Engineering**:
   - Aggregated game-level statistics to season-level metrics
   - Created per-game averages and efficiency rates
   - Generated advanced metrics (PPA, success rates, field position)

3. **Feature Selection**:
   - **LASSO Regression**: Initial feature screening from 50+ variables
   - **VIF Analysis**: Addressed multicollinearity (all VIF < 5)
   - **Backward Selection**: AIC-based stepwise reduction

4. **Model Training**:
   - 70/30 train-test split
   - Linear regression on 10 final predictors
   - Cross-validation on random sample

5. **Diagnostics**:
   - Residual analysis (linearity, homoscedasticity)
   - Leverage & Cook's Distance (influence detection)
   - PRESS statistic (prediction error)

### Final Model Variables

| Variable | Description |
|----------|-------------|
| `rushing_yards` | Total rushing yards (season) |
| `turnovers` | Total turnovers committed |
| `off_stuff_rate` | % of rushes for ≤0 yards |
| `off_rushing_plays_rate` | % of plays that are rushes |
| `def_passing_plays_rate` | % of opponent plays that are passes |
| `off_drives` | Total offensive drives |
| `off_total_opportunities` | Scoring opportunities (40-yard line+) |
| `off_passing_plays_success_rate` | % of successful passing plays |
| `points_allowed_pg` | Points allowed per game |
| `def_field_pos_avg_start` | Avg opponent starting field position |

## 📊 Sample Visualizations

The project includes 20+ publication-quality visualizations using team logos and color schemes:

- **Rushing Yards vs Wins**: Correlation between ground game and success
- **Offensive/Defensive Balance**: Yards gained vs yards allowed
- **Turnover Impact**: Effect of ball security on win totals
- **QB Performance Metrics**: Top 10 seasons by passing %, TDs, rushing TDs
- **Predicted vs Actual Wins**: Model validation scatter plots

All plots feature:
- Official team logos (via `cfbplotR`)
- Mean reference lines
- Trend lines (where appropriate)
- National championship markers (★)
- Team records and seasons as labels

## 📝 Key Insights

### What Makes an Elite Team? 

1. **Offensive Efficiency > Volume**: Success rate and stuff rate matter more than total yards
2. **Defensive Field Position**: Elite defenses force opponents to start deep in their territory
3. **Possession Structure**: Number of drives and scoring opportunities strongly predict wins
4. **Ball Security**: Turnovers remain a critical differentiator

### The Dual-Threat Evolution

1. **Historical Shift**: Rise of mobile QBs from 2010s onward (Cam Newton, Lamar Jackson, Kyler Murray)
2. **Statistical Profile**: Modern dual-threats combine 60%+ completion with 500+ rushing yards
3. **Efficiency vs Volume**: QBR correlates more with decision-making than raw production

## 🎓 Data Sources

- **cfbfastR**: Game-level and season-level team/player statistics (2004–2025)
- **247Sports**: Talent composite data (2015–present, not used due to limited history)
- **Bleacher Report**: Historical team rankings for elite team selection

## ⚠️ Limitations

- Data only available from 2004 onwards (excludes historic teams like 2001 Miami)
- Elite team sample may not generalize to all FBS teams
- Talent composite data unavailable before 2015
- QBR is ESPN's proprietary metric (black box components)

## 🔮 Future Work

- [ ] Expand to full FBS random sample (500+ team-seasons)
- [ ] Incorporate recruiting rankings (2015+)
- [ ] Time-series analysis of strategy evolution
- [ ] Playoff probability models (CFP era 2014+)
- [ ] Machine learning models (Random Forest, XGBoost)
- [ ] Conference-level comparative analysis

## 📚 References

Gilani, S., Easwaran, A., Lee, J., & Hess, E. (2021). *cfbfastR: The SportsDataverse's R package for college football data. * https://cfbfastR.sportsdataverse.org/

Bleacher Report. (2020). *The 10 best college football teams of all time.* https://bleacherreport.com/articles/2885279-the-10-best-college-football-teams-of-all-time

OpenAI. (2025). *ChatGPT (Version 5. 1)* [Large language model]. https://chat.openai.com/

## 👤 Author

**Jake Blumengarten**  
📧 blumengartenjake@gmail.com  
🔗 [LinkedIn](https://www.linkedin.com/in/jake-blumengarten)  
💻 [GitHub](https://github.com/JakeBlumengarten)

---

*This project showcases statistical modeling, data visualization, and sports analytics skills for data analyst positions. All code and analysis are original work with assistance from ChatGPT for debugging and formatting.*

## 📄 License

This project is available for educational and portfolio purposes. Data sourced from publicly available APIs (cfbfastR).

---

⭐ **If you found this analysis interesting, please consider starring the repository! **
