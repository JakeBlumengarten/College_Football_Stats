library(ggplot2)
library(cfbplotR)
library(ggrepel)

plot_variable_vs_wins <- function(data, var, team_col = "team", season_col = "season", save_path = NULL) {
  
  # make variable symbols for ggplot
  var_sym <- rlang::sym(var)
  
  # compute min/max for x-axis safely
  x_min <- floor(min(data[[var]], na.rm = TRUE)/10)*10
  x_max <- ceiling(max(data[[var]], na.rm = TRUE)/10)*10
  
  y_min <- floor(min(data$total_wins, na.rm = TRUE)/10)*10
  y_max <- ceiling(max(data$total_wins, na.rm = TRUE)/10)*10
  
  p <- ggplot(data, aes(x = !!var_sym, y = total_wins)) +
    geom_mean_lines(aes(v_var = !!var_sym, h_var = total_wins),
                    color = "grey70", linetype = "dashed", size = 0.5) +
    geom_cfb_logos(aes(team = !!rlang::sym(team_col)),
                   width = 0.055, alpha = 0.85) +
    geom_smooth(method = lm, se = FALSE, color = "grey40", linewidth = 0.8) +
    geom_text_repel(aes(label = sprintf("(%d)", !!rlang::sym(season_col))),
                    size = 2.6, fontface = "bold",
                    box.padding = 0.4, point.padding = 0.3,
                    max.overlaps = Inf,
                    segment.color = "black", segment.size = 0.3) +
    scale_y_continuous(breaks = seq(y_min, y_max, by = 1)) +
    labs(
      title = paste0(var, " vs Wins"),
      subtitle = "Dashed lines indicate group averages",
      x = paste0("Total ", var, " (Season)"),
      y = "Total Wins",
      caption = "Data: cfbfastR / cfbplotR"
    ) +
    theme_test(base_size = 11)
  
  if(!is.null(save_path)) {
    ggsave(filename = save_path, plot = p, width = 11, height = 8, dpi = 300)
  }
  
  return(p)
}

penalties_pg <- plot_variable_vs_wins(
  data = teams_random_stats,
  var = "penalties_pg",
  save_path = "Plots/random_sample/penalties_pg.png"
)

