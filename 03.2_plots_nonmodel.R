plot_yards_vs_allowed <- season_stats %>%
  ggplot(aes(x = total_yards_pg, y = total_yards_allowed_pg)) +
  
  # Mean lines
  geom_mean_lines(
    aes(v_var = total_yards_pg, h_var = total_yards_allowed_pg),
    color = "grey70",
    linetype = "dashed",
    size = 0.5
  ) +
  
  # Logos
  geom_cfb_logos(
    aes(team = school),
    width = 0.055,
    alpha = 0.85
  ) +
  
  # Trend line
  geom_smooth(method = lm, se = FALSE, color = "grey40", linewidth = 0.8) +
  
  # Labels
  geom_text_repel(
    aes(label = sprintf("%d–%d (%d)",
                        total_wins, total_losses, season)),
    size = 2.6,
    fontface = "bold",
    box.padding = 0.4,
    point.padding = 0.3,
    max.overlaps = Inf,
    segment.color = "black",
    segment.size = 0.3
  ) +
  
  # Champion marker
  geom_point(
    data = season_stats %>% filter(champion),
    aes(x = total_yards_pg, y = total_yards_allowed_pg),
    shape = 8,
    size = 3,
    color = "#F4B400"
  ) +
  
  # Axes every 10 yards
  scale_x_continuous(
    breaks = seq(
      floor(min(season_stats$total_yards_pg) / 10) * 10,
      ceiling(max(season_stats$total_yards_pg) / 10) * 10,
      by = 10
    )
  ) +
  scale_y_continuous(
    breaks = seq(
      floor(min(season_stats$total_yards_allowed_pg) / 10) * 10,
      ceiling(max(season_stats$total_yards_allowed_pg) / 10) * 10,
      by = 10
    )
  ) +
  
  # Labels
  labs(
    title = "Offensive Production vs Defensive Allowance (Per Game)",
    subtitle = "Each label shows team, record, and season\nDashed lines indicate group averages",
    x = "Offensive Yards per Game",
    y = "Defensive Yards Allowed per Game",
    caption = "★ indicates national champion season • Data: cfbfastR / cfbplotR"
  ) +
  
  theme_test(base_size = 11)

plot_yards_vs_allowed

# ✅ SAVE IT
ggsave(
  filename = "Plots/yards_for_vs_yards_allowed_per_game.png",
  plot = plot_yards_vs_allowed,
  width = 11,
  height = 8,
  dpi = 300
)

#-----------------------------------

off_explosiveness <- season_stats %>%
  ggplot(aes(x = off_explosiveness, y = total_wins)) +
  
  # Mean lines
  geom_mean_lines(
    aes(v_var = off_explosiveness, h_var = total_wins),
    color = "grey70",
    linetype = "dashed",
    size = 0.5
  ) +
  
  # Logos
  geom_cfb_logos(
    aes(team = school),
    width = 0.055,
    alpha = 0.85
  ) +
  
  # Labels
  geom_text_repel(
    aes(label = sprintf("%d–%d (%d)", total_wins, total_losses, season)),
    size = 2.6,
    fontface = "bold",
    box.padding = 0.4,
    point.padding = 0.3,
    max.overlaps = Inf,
    segment.color = "black",
    segment.size = 0.3
  ) +
  
  # Champion marker
  geom_point(
    data = season_stats %>% filter(champion),
    aes(x = off_explosiveness, y = total_wins),
    shape = 8,
    size = 3,
    color = "#F4B400"
  ) +
  
  # Trend line
  geom_smooth(method = lm, se = FALSE, color = "grey40", linewidth = 0.8) +
  
  labs(
    title = "Offensive Explosiveness vs Total Wins",
    subtitle = "Each point represents a team season; dashed lines indicate group means",
    x = "Offensive Explosiveness",
    y = "Total Wins",
    caption = "★ indicates national champion season • Data: cfbfastR / cfbplotR"
  ) +
  
  scale_y_continuous(
    breaks = seq(
      floor(min(season_stats$total_wins)),
      ceiling(max(season_stats$total_wins)),
      by = 1
    )
  ) +
  scale_x_continuous(
    breaks = seq(
      floor(min(season_stats$off_explosiveness) * 10) / 10,
      ceiling(max(season_stats$off_explosiveness) * 10) / 10,
      by = 0.1
    )
  )+
  
  theme_test(base_size = 11)

off_explosiveness

# ✅ SAVE IT
ggsave(
  filename = "Plots/off_explosiveness.png",
  plot = off_explosiveness,
  width = 11,
  height = 8,
  dpi = 300
)

success_rate <- season_stats %>%
  ggplot(aes(x = off_explosiveness, y = total_wins)) +
  
  # Mean lines
  geom_mean_lines(
    aes(v_var = off_explosiveness, h_var = total_wins),
    color = "grey70",
    linetype = "dashed",
    size = 0.5
  ) +
  
  # Logos
  geom_cfb_logos(
    aes(team = school),
    width = 0.055,
    alpha = 0.85
  ) +
  
  # Labels
  geom_text_repel(
    aes(label = sprintf("%d–%d (%d)", total_wins, total_losses, season)),
    size = 2.6,
    fontface = "bold",
    box.padding = 0.4,
    point.padding = 0.3,
    max.overlaps = Inf,
    segment.color = "black",
    segment.size = 0.3
  ) +
  
  # Champion marker
  geom_point(
    data = season_stats %>% filter(champion),
    aes(x = off_explosiveness, y = total_wins),
    shape = 8,
    size = 3,
    color = "#F4B400"
  ) +
  
  # Trend line
  geom_smooth(method = lm, se = FALSE, color = "grey40", linewidth = 0.8) +
  
  labs(
    title = "Offensive Explosiveness vs Total Wins",
    subtitle = "Each point represents a team season; dashed lines indicate group means",
    x = "Offensive Explosiveness",
    y = "Total Wins",
    caption = "★ indicates national champion season • Data: cfbfastR / cfbplotR"
  ) +
  
  scale_y_continuous(
    breaks = seq(
      floor(min(season_stats$total_wins)),
      ceiling(max(season_stats$total_wins)),
      by = 1
    )
  ) +
  scale_x_continuous(
    breaks = seq(
      floor(min(season_stats$off_explosiveness) * 10) / 10,
      ceiling(max(season_stats$off_explosiveness) * 10) / 10,
      by = 0.1
    )
  )+
  
  theme_test(base_size = 11)

off_explosiveness

# ✅ SAVE IT
ggsave(
  filename = "Plots/off_explosiveness.png",
  plot = off_explosiveness,
  width = 11,
  height = 8,
  dpi = 300
)
