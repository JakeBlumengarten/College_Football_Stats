library(ggplot2)
library(cfbplotR)
library(ggrepel)

# --------------------------

rushing_yards <- season_stats %>%
  ggplot(aes(x = rushing_yards, y = total_wins)) +
  
  # Mean lines
  geom_mean_lines(
    aes(v_var = rushing_yards, h_var = total_wins),
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
    aes(x = rushing_yards, y = total_wins),
    shape = 8,
    size = 3,
    color = "#F4B400"
  ) +
  
  scale_x_continuous(
    breaks = seq(
      floor(min(season_stats$rushing_yards) / 10) * 10,
      ceiling(max(season_stats$rushing_yards) / 10) * 10,
      by = 150
    )
  ) +
  scale_y_continuous(
    breaks = seq(
      floor(min(season_stats$total_wins) / 10) * 10,
      ceiling(max(season_stats$total_wins) / 10) * 10,
      by = 1
    )
  ) +
  
  # Labels
  labs(
    title = "Rushing Yards vs Wins",
    subtitle = "Each label shows team, record, and season\nDashed lines indicate group averages",
    x = "Total Rushing Yards (Season)",
    y = "Total Wins",
    caption = "★ indicates national champion season • Data: cfbfastR / cfbplotR"
  ) +
  
  theme_test(base_size = 11)

rushing_yards

# ✅ SAVE IT
ggsave(
  filename = "Plots/rushing_yards.png",
  plot = rushing_yards,
  width = 11,
  height = 8,
  dpi = 300
)

# --------------------------

turnovers <- season_stats %>%
  ggplot(aes(x = turnovers, y = total_wins)) +
  
  # Mean lines
  geom_mean_lines(
    aes(v_var = turnovers, h_var = total_wins),
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
    aes(x = turnovers, y = total_wins),
    shape = 8,
    size = 3,
    color = "#F4B400"
  ) +
  
  # Axes every 10 yards
  scale_x_continuous(
    breaks = seq(
      floor(min(season_stats$turnovers) / 10) * 10,
      ceiling(max(season_stats$turnovers) / 10) * 10,
      by = 1
    )
  ) +
  scale_y_continuous(
    breaks = seq(
      floor(min(season_stats$total_wins) / 10) * 10,
      ceiling(max(season_stats$total_wins) / 10) * 10,
      by = 1
    )
  ) +
  
  # Labels
  labs(
    title = "Turnovers vs Wins",
    subtitle = "Each label shows team, record, and season\nDashed lines indicate group averages",
    x = "Total Turnovers (Season)",
    y = "Total Wins",
    caption = "★ indicates national champion season • Data: cfbfastR / cfbplotR"
  ) +
  
  theme_test(base_size = 11)

turnovers

# ✅ SAVE IT
ggsave(
  filename = "Plots/turnovers.png",
  plot = turnovers,
  width = 11,
  height = 8,
  dpi = 300
)


# --------------------------

off_drives <- season_stats %>%
  ggplot(aes(x = off_drives, y = total_wins)) +
  
  # Mean lines
  geom_mean_lines(
    aes(v_var = off_drives, h_var = total_wins),
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
    aes(x = off_drives, y = total_wins),
    shape = 8,
    size = 3,
    color = "#F4B400"
  ) +
  
  # Axes every 10 yards
  scale_x_continuous(
    breaks = seq(
      floor(min(season_stats$off_drives) / 10) * 10,
      ceiling(max(season_stats$off_drives) / 10) * 10,
      by = 10
    )
  ) +
  scale_y_continuous(
    breaks = seq(
      floor(min(season_stats$total_wins) / 10) * 10,
      ceiling(max(season_stats$total_wins) / 10) * 10,
      by = 1
    )
  ) +
  
  # Labels
  labs(
    title = "Offensive Drives vs Wins",
    subtitle = "Each label shows team, record, and season\nDashed lines indicate group averages",
    x = "Total Drives (Season)",
    y = "Total Wins",
    caption = "★ indicates national champion season • Data: cfbfastR / cfbplotR"
  ) +
  
  theme_test(base_size = 11)

off_drives

# ✅ SAVE IT
ggsave(
  filename = "Plots/off_drives.png",
  plot = off_drives,
  width = 11,
  height = 8,
  dpi = 300
)

# --------------------------

off_stuff_rate <- season_stats %>%
  ggplot(aes(x = off_stuff_rate, y = total_wins)) +
  
  # Mean lines
  geom_mean_lines(
    aes(v_var = off_stuff_rate, h_var = total_wins),
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
    aes(x = off_stuff_rate, y = total_wins),
    shape = 8,
    size = 3,
    color = "#F4B400"
  ) +
  
  # Axes every 10 yards
  scale_x_continuous(
    breaks = seq(
      floor(min(season_stats$off_stuff_rate) / 10) * 10,
      ceiling(max(season_stats$off_stuff_rate) / 10) * 10,
      by = 0.1
    )
  ) +
  scale_y_continuous(
    breaks = seq(
      floor(min(season_stats$total_wins) / 10) * 10,
      ceiling(max(season_stats$total_wins) / 10) * 10,
      by = 1
    )
  ) +
  
  # Labels
  labs(
    title = "Offensive Drives vs Wins",
    subtitle = "Each label shows team, record, and season\nDashed lines indicate group averages\n 
    `off_stuff_rate`: Percentage of a team's running plays that are tackled for negative yards or no gain on a running play",
    x = "Offensive Stuff Rate",
    y = "Total Wins",
    caption = "★ indicates national champion season • Data: cfbfastR / cfbplotR"
  ) +
  
  theme_test(base_size = 11)

off_stuff_rate

# ✅ SAVE IT
ggsave(
  filename = "Plots/off_stuff_rate.png",
  plot = off_stuff_rate,
  width = 11,
  height = 8,
  dpi = 300
)

# --------------------------

off_total_opportunities <- season_stats %>%
  ggplot(aes(x = off_total_opportunities, y = total_wins)) +
  
  # Mean lines
  geom_mean_lines(
    aes(v_var = off_total_opportunities, h_var = total_wins),
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
    aes(x = off_total_opportunities, y = total_wins),
    shape = 8,
    size = 3,
    color = "#F4B400"
  ) +
  
  # Axes every 10 yards
  scale_x_continuous(
    breaks = seq(
      floor(min(season_stats$off_total_opportunities) / 10) * 10,
      ceiling(max(season_stats$off_total_opportunities) / 10) * 10,
      by = 15
    )
  ) +
  scale_y_continuous(
    breaks = seq(
      floor(min(season_stats$total_wins) / 10) * 10,
      ceiling(max(season_stats$total_wins) / 10) * 10,
      by = 1
    )
  ) +
  
  # Labels
  labs(
    title = "Total Offensive Opportunity vs Wins",
    subtitle = "Each label shows team, record, and season\nDashed lines indicate group averages",
    x = "Total Offensive Possessions (Season)",
    y = "Total Wins",
    caption = "★ indicates national champion season • Data: cfbfastR / cfbplotR"
  ) +
  
  theme_test(base_size = 11)

off_total_opportunities

# ✅ SAVE IT
ggsave(
  filename = "Plots/off_total_opportunities.png",
  plot = off_total_opportunities,
  width = 11,
  height = 8,
  dpi = 300
)

# --------------------------

off_rushing_plays_rate <- season_stats %>%
  ggplot(aes(x = off_rushing_plays_rate, y = total_wins)) +
  
  # Mean lines
  geom_mean_lines(
    aes(v_var = off_rushing_plays_rate, h_var = total_wins),
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
    aes(x = off_rushing_plays_rate, y = total_wins),
    shape = 8,
    size = 3,
    color = "#F4B400"
  ) +
  
  # Axes every 10 yards
  scale_x_continuous(
    breaks = seq(
      floor(min(season_stats$off_rushing_plays_rate) / 10) * 10,
      ceiling(max(season_stats$off_rushing_plays_rate) / 10) * 10,
      by = 0.05
    )
  ) +
  scale_y_continuous(
    breaks = seq(
      floor(min(season_stats$total_wins) / 10) * 10,
      ceiling(max(season_stats$total_wins) / 10) * 10,
      by = 1
    )
  ) +
  
  # Labels
  labs(
    title = "Offensive Rushing Plays Rate vs Wins",
    subtitle = "Each label shows team, record, and season\nDashed lines indicate group averages",
    x = "Percentage of Offense's Total Plays that are Rushing Plays (Season)",
    y = "Total Wins",
    caption = "★ indicates national champion season • Data: cfbfastR / cfbplotR"
  ) +
  
  theme_test(base_size = 11)

off_rushing_plays_rate

# ✅ SAVE IT
ggsave(
  filename = "Plots/off_rushing_plays_rate.png",
  plot = off_rushing_plays_rate,
  width = 11,
  height = 8,
  dpi = 300
)

# --------------------------

off_passing_plays_success_rate <- season_stats %>%
  ggplot(aes(x = off_passing_plays_success_rate, y = total_wins)) +
  
  # Mean lines
  geom_mean_lines(
    aes(v_var = off_passing_plays_success_rate, h_var = total_wins),
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
    aes(x = off_passing_plays_success_rate, y = total_wins),
    shape = 8,
    size = 3,
    color = "#F4B400"
  ) +
  
  # Axes every 10 yards
  scale_x_continuous(
    breaks = seq(
      floor(min(season_stats$off_passing_plays_success_rate) / 10) * 10,
      ceiling(max(season_stats$off_passing_plays_success_rate) / 10) * 10,
      by = 0.05
    )
  ) +
  scale_y_continuous(
    breaks = seq(
      floor(min(season_stats$total_wins) / 10) * 10,
      ceiling(max(season_stats$total_wins) / 10) * 10,
      by = 1
    )
  ) +
  
  # Labels
  labs(
    title = "Pass Plays Success Rate vs Wins",
    subtitle = "Each label shows team, record, and season\nDashed lines indicate group averages",
    x = "Offensive Passing Plays Success Rate",
    y = "Total Wins",
    caption = "★ indicates national champion season • Data: cfbfastR / cfbplotR"
  ) +
  
  theme_test(base_size = 11)

off_passing_plays_success_rate

# ✅ SAVE IT
ggsave(
  filename = "Plots/off_passing_plays_success_rate.png",
  plot = off_passing_plays_success_rate,
  width = 11,
  height = 8,
  dpi = 300
)

# --------------------------

points_allowed_pg <- season_stats %>%
  ggplot(aes(x = points_allowed_pg, y = total_wins)) +
  
  # Mean lines
  geom_mean_lines(
    aes(v_var = points_allowed_pg, h_var = total_wins),
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
    aes(x = points_allowed_pg, y = total_wins),
    shape = 8,
    size = 3,
    color = "#F4B400"
  ) +
  
  # Axes every 10 yards
  scale_x_continuous(
    breaks = seq(
      floor(min(season_stats$points_allowed_pg) / 10) * 10,
      ceiling(max(season_stats$points_allowed_pg) / 10) * 10,
      by = 5
    )
  ) +
  scale_y_continuous(
    breaks = seq(
      floor(min(season_stats$total_wins) / 10) * 10,
      ceiling(max(season_stats$total_wins) / 10) * 10,
      by = 1
    )
  ) +
  
  # Labels
  labs(
    title = "Points Allowed Per Game vs Wins",
    subtitle = "Each label shows team, record, and season\nDashed lines indicate group averages",
    x = "Points Allowed (Game)",
    y = "Total Wins",
    caption = "★ indicates national champion season • Data: cfbfastR / cfbplotR"
  ) +
  
  theme_test(base_size = 11)

points_allowed_pg

# ✅ SAVE IT
ggsave(
  filename = "Plots/points_allowed_pg.png",
  plot = points_allowed_pg,
  width = 11,
  height = 8,
  dpi = 300
)

# --------------------------

def_field_pos_avg_start <- season_stats %>%
  ggplot(aes(x = def_field_pos_avg_start, y = total_wins)) +
  
  # Mean lines
  geom_mean_lines(
    aes(v_var = def_field_pos_avg_start, h_var = total_wins),
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
    aes(x = def_field_pos_avg_start, y = total_wins),
    shape = 8,
    size = 3,
    color = "#F4B400"
  ) +
  
  # Axes every 10 yards
  scale_x_continuous(
    breaks = seq(
      floor(min(season_stats$def_field_pos_avg_start) / 10) * 10,
      ceiling(max(season_stats$def_field_pos_avg_start) / 10) * 10,
      by = 1
    )
  ) +
  scale_y_continuous(
    breaks = seq(
      floor(min(season_stats$total_wins) / 10) * 10,
      ceiling(max(season_stats$total_wins) / 10) * 10,
      by = 1
    )
  ) +
  
  # Labels
  labs(
    title = "Defensive Field Position Average Start vs Wins",
    subtitle = "Each label shows team, record, and season\nDashed lines indicate group averages",
    x = "Defense Field Position Average Start",
    y = "Total Wins",
    caption = "★ indicates national champion season • Data: cfbfastR / cfbplotR"
  ) +
  
  theme_test(base_size = 11)

def_field_pos_avg_start

# ✅ SAVE IT
ggsave(
  filename = "Plots/def_field_pos_avg_start.png",
  plot = def_field_pos_avg_start,
  width = 11,
  height = 8,
  dpi = 300
)

def_passing_plays_rate <- season_stats %>%
  ggplot(aes(x = def_passing_plays_rate, y = total_wins)) +
  
  # Mean lines
  geom_mean_lines(
    aes(v_var = def_passing_plays_rate, h_var = total_wins),
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
    aes(x = def_passing_plays_rate, y = total_wins),
    shape = 8,
    size = 3,
    color = "#F4B400"
  ) +
  
  # Axes every 10 yards
  scale_x_continuous(
    breaks = seq(
      floor(min(season_stats$def_passing_plays_rate) / 10) * 10,
      ceiling(max(season_stats$def_passing_plays_rate) / 10) * 10,
      by = 0.01
    )
  ) +
  scale_y_continuous(
    breaks = seq(
      floor(min(season_stats$total_wins) / 10) * 10,
      ceiling(max(season_stats$total_wins) / 10) * 10,
      by = 1
    )
  ) +
  
  # Labels
  labs(
    title = "Defensive Passing Plays Rate vs Wins",
    subtitle = "Each label shows team, record, and season\nDashed lines indicate group averages\ndef_passing_plays_rate: Frequency at which a specific defense faces passing plays",
    x = "Defensive Passing Plays Rate (Season)",
    y = "Total Wins",
    caption = "★ indicates national champion season • Data: cfbfastR / cfbplotR"
  ) +
  
  theme_test(base_size = 11)

def_passing_plays_rate

# ✅ SAVE IT
ggsave(
  filename = "Plots/def_passing_plays_rate.png",
  plot = def_passing_plays_rate,
  width = 11,
  height = 8,
  dpi = 300
)
