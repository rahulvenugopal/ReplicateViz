# Replicating the dating history of Leonardo DiCaprio ---------------------
# Focus is on the chains of data in terms of recreating a visualisation
# I saw this post https://twitter.com/dollarsanddata/status/1564743654450806792
# Decided to replicate the Viz from scratch and may be extend it a bit

# Loading libraries -------------------------------------------------------

library(tidyverse)
library(ggCyberPunk)
library(ggtext)
library(gghighlight)

# Create dataframe --------------------------------------------------------

df_raw <- data.frame(Years=seq(from = 1998, to = 2022),
                Leo_age=seq(from = 24, to = 48),
                GF_age=c(18,19,20,21,22,23,20,21,22,23,24,25,
                       23,22,20,21,25,24,25,20,21,22,23,24,25))

df <- df_raw
df$Years <- as.factor(df$Years)

# Adding the girlfriends age barplots
gf_data <- df_raw %>% select(-Leo_age)

vals <- lapply(gf_data$GF_age, function(y) seq(0, y, by = 0.01))
# the 0.01 controls the smoothness of the bar
y <- unlist(vals)
mid <- rep(gf_data$Years, lengths(vals))

just_gf_ages <- data.frame(x = mid - 0.3, xend = mid + 0.2, y = y, yend = y)

# Theming -----------------------------------------------------------------

# change global theme settings (for all following plots)
theme_set(theme_cyberpunk(
  plot.background.color = "#0a001e",
  panel.background = "#0a001e",
  panel.border.color = "#0a001e",
  main.text.color = "#bcbcbc",
  axis.text.color = "#bcbcbc",
  legend.position = "None",
  panel.grid.color = "#0a001e",
  base.size = 8,
  font = "Aldrich"
))

theme_update(
  axis.ticks = element_line(),
  axis.ticks.length = unit(0.25, "lines"),
  panel.grid.major.y = element_line(color = "#16152a",
                                    size = 0.75,
                                    linetype = 1),
  axis.text.x = element_text(size = 9),
  axis.text.y = element_text(size = 9),
  plot.title = element_markdown(size = 14),
  plot.subtitle = element_markdown(size = 10),
  plot.caption = element_markdown(size = 10,
                                  hjust = 1, vjust = 0), # to move caption around
  plot.title.position = "plot", # keeps the text aligned to outer end of margins
  plot.margin = margin(t = 20, r = 20, b = 20, l = 20),
  axis.title.y = element_blank(),# removing axis titles
  axis.title.x = element_blank()
)

# Let the Viz begin -------------------------------------------------------

viz_leo <- ggplot(df, aes(x = Years, y = Leo_age)) + 
  
  # line and dots
  geom_line(aes(group = 1), color = "#ff7400") + 
  
  geom_point(size = 4,
             pch = 21,
             fill = "#0a001e",
             color = "#ff7400") +
  
  # adding age above the dot for Leo
  geom_text(data = df,
            aes(label = Leo_age),
            color = "#ff7400",
            vjust=-1) +
  
  # Girl friends age barplot
  geom_bar(stat = "identity",
           width = 0.25,
           fill = "#01f7f8",
           alpha = 0.75,
           aes(x = Years, y = GF_age)) +
  
  # adding age above the dot for Girlfriends
  geom_text(data = df,
            aes(label = GF_age,
                y = GF_age),
            color = "#01f7f8",
            vjust=-0.5) +
  
  scale_y_continuous(breaks = seq(0, 50, by = 2)) + # control axis breaks
  
  expand_limits(y = 0) +# forcing the axis to start from zero
  
  # Adding annotations to Leo line part of the Viz
  annotate(geom = "text", x = 1, y = 47,
           label = "Median age of girlfriends = 22",
           hjust = "left",
           size = 4,
           family= "Aldrich", # annotate by default don't inherit font
           color = "#01f7f8") + 
  
  # Trivia add
  annotate(geom = "text", x = 8, y = 47,
           label = "Titanic movie got released 25 years ago",
           hjust = "left",
           size = 4,
           family= "Aldrich", # annotate by default don't inherit font
           color = "#bcbcbc") + 
  
  annotate(geom = "text", x = 1, y = 45,
           label = "Well, Leonardo ages linearly!",
           hjust = "left",
           size = 4,
           family= "Aldrich", # annotate by default don't inherit font
           color = "#ff7400") + 
  
  geom_richtext(aes(x = 2, y = 39),
                fill = NA, label.color = NA,
                nudge_x = 0,
                nudge_y = 0,
                hjust = 0,
                label = "Leo turned <span style='color:#ff7400'> 25 </span> years old in the year 1999",
                size = 3,
                family= "Aldrich", # annotate by default don't inherit font
                color = "#bcbcbc") + 
  
  geom_richtext(aes(x = 2, y = 37),
                fill = NA, label.color = NA,
                nudge_x = 0,
                nudge_y = 0,
                hjust = 0,
                label = "His current partner turned <span style='color:#01f7f8'> 2 </span>years old",
                size = 3,
                family= "Aldrich", # annotate by default don't inherit font
                color = "#bcbcbc") + 
  
  annotate(geom = "curve",
           x = 2, y = 27,
           xend = 2, yend = 36.2,
           curvature = -.3,
           color = "#bcbcbc",
           alpha = 0.8,
           linetype = 1, # dotted lines
           arrow = arrow(length = unit(2, "mm"))) +
  
  labs(title = '<i style="color:#ff7400;">**LEONARDO DECAPRIO**</i> 
       REFUSES TO DATE <i style="color:#01f7f8;">**A WOMAN HIS AGE**</i>',
       
       subtitle = 'HE GETS <i/b style="color:#ff7400;">OLDER</i>, THEY STAY THE <i style="color:#01f7f8;">SAME AGE</i>
       LEO IS <i/b style="color:#ff7400;">45<sup>+</sup></i> NOW BUT STILL CONSISTENTLY DATES
       WOMEN <i/b style="color:#01f7f8;"> less than 26 </i>')

ggsave("images/Leo_replicate_viz.pdf",
       width = 14,
       height = 8,
       units="in",
       device = cairo_pdf)