library(ggplot2)
library(readr)
library(cfbplotR)

passing_pct <- players %>%
  arrange(desc(passing_pct)) %>%
  slice_head(n = 10) %>%
  mutate(label = paste(player, year)) %>%
  ggplot(aes(
    x = passing_pct,
    y = reorder(label, passing_pct),
    fill = team
  )) +
  geom_col(width = 0.7) +
  
  # TEAM COLORS
  scale_fill_cfb() +
  
  # TEAM LOGOS
  geom_cfb_logos(
    aes(team = team, x = passing_pct + (passing_pct * 0.04)),
    width = 0.06
  ) +
  
  geom_text(aes(
    x = passing_pct /2, 
    label = qb_type
  ), hjust = 0, size = 3, fontface = "bold", color = "white") +
  
  labs(
    title = "Top 10 QB Seasons by Completion Percentage",
    x = "Completion Percentage",
    y = ""
  ) +
  theme_minimal() +
  theme(
    legend.position = "none",
    panel.grid.major.y = element_blank()
  ) +
  coord_cartesian(clip = "off")

ggsave(
  filename = "Plots/player_plots/top_10_passing_pct.png",
  plot = passing_pct,
  width = 11,
  height = 8,
  dpi = 300
)

passing_td <- players %>%
  arrange(desc(passing_td)) %>%
  slice_head(n = 10) %>%
  mutate(label = paste(player, year)) %>%
  ggplot(aes(
    x = passing_td,
    y = reorder(label, passing_td),
    fill = team
  )) +
  geom_col(width = 0.7) +
  
  # TEAM COLORS
  scale_fill_cfb() +
  
  # TEAM LOGOS
  geom_cfb_logos(
    aes(team = team, x = passing_td + (passing_td * 0.04)),
    width = 0.06
  ) +
  
  geom_text(aes(
    x = passing_td /2, 
    label = qb_type
  ), hjust = 0, size = 3, fontface = "bold", color = "white") +
  
  labs(
    title = "Top 10 QB Seasons by Passing Touchdowns",
    x = "Passing Touchdowns",
    y = ""
  ) +
  theme_minimal() +
  theme(
    legend.position = "none",
    panel.grid.major.y = element_blank()
  ) +
  coord_cartesian(clip = "off")

ggsave(
  filename = "Plots/player_plots/top_10_passing_td.png",
  plot = passing_td,
  width = 11,
  height = 8,
  dpi = 300
)


rushing_td <- players %>%
  arrange(desc(rushing_td)) %>%
  slice_head(n = 10) %>%
  mutate(label = paste(player, year)) %>%
  ggplot(aes(
    x = rushing_td,
    y = reorder(label, rushing_td),
    fill = team
  )) +
  geom_col(width = 0.7) +
  
  # TEAM COLORS
  scale_fill_cfb() +
  
  # TEAM LOGOS
  geom_cfb_logos(
    aes(team = team, x = rushing_td + (rushing_td * 0.04)),
    width = 0.06
  ) +
  
  geom_text(aes(
    x = rushing_td /2, 
    label = qb_type
  ), hjust = 0, size = 3, fontface = "bold", color = "white") +
  
  labs(
    title = "Top 10 QB Seasons by Rushing Touchdowns",
    x = "Rushing Touchdowns",
    y = ""
  ) +
  theme_minimal() +
  theme(
    legend.position = "none",
    panel.grid.major.y = element_blank()
  ) +
  coord_cartesian(clip = "off")

ggsave(
  filename = "Plots/player_plots/top_10_rushing_td.png",
  plot = rushing_td,
  width = 11,
  height = 8,
  dpi = 300
)

passing_ypa <- players %>%
  arrange(desc(passing_ypa)) %>%
  slice_head(n = 10) %>%
  mutate(label = paste(player, year)) %>%
  ggplot(aes(
    x = passing_ypa,
    y = reorder(label, passing_ypa),
    fill = team
  )) +
  geom_col(width = 0.7) +
  
  # TEAM COLORS
  scale_fill_cfb() +
  
  # TEAM LOGOS
  geom_cfb_logos(
    aes(team = team, x = passing_ypa + (passing_ypa * 0.04)),
    width = 0.06
  ) +
  
  geom_text(aes(
    x = passing_ypa /2, 
    label = qb_type
  ), hjust = 0, size = 3, fontface = "bold", color = "white") +
  
  labs(
    title = "Top 10 QB Seasons by Passing Yards Per Attempt (YPA)",
    x = "Passing YPA",
    y = ""
  ) +
  theme_minimal() +
  theme(
    legend.position = "none",
    panel.grid.major.y = element_blank()
  ) +
  coord_cartesian(clip = "off")

ggsave(
  filename = "Plots/player_plots/top_10_passing_ypa.png",
  plot = passing_ypa,
  width = 11,
  height = 8,
  dpi = 300
)

rushing_ypc <- players %>%
  arrange(desc(rushing_ypc)) %>%
  slice_head(n = 10) %>%
  mutate(label = paste(player, year)) %>%
  ggplot(aes(
    x = rushing_ypc,
    y = reorder(label, rushing_ypc),
    fill = team
  )) +
  geom_col(width = 0.7) +
  
  # TEAM COLORS
  scale_fill_cfb() +
  
  # TEAM LOGOS
  geom_cfb_logos(
    aes(team = team, x = rushing_ypc + (rushing_ypc * 0.04)),
    width = 0.06
  ) +
  
  geom_text(aes(
    x = rushing_ypc /2, 
    label = qb_type
  ), hjust = 0, size = 3, fontface = "bold", color = "white") +
  
  labs(
    title = "Top 10 QB Seasons by Rushing Yards Per Carry (YPC)",
    x = "Rushing YPC",
    y = ""
  ) +
  theme_minimal() +
  theme(
    legend.position = "none",
    panel.grid.major.y = element_blank()
  ) +
  coord_cartesian(clip = "off")

ggsave(
  filename = "Plots/player_plots/top_10_rushing_ypc.png",
  plot = rushing_ypc,
  width = 11,
  height = 8,
  dpi = 300
)

