# Recreate the wind turbines are not killing fields for birds viz
# https://www.fws.gov/library/collections/threats-birds for data
# I saw the viz being shared by Sophia Kianni
# https://twitter.com/SophiaKianni/status/1680454347031982083?s=20

# Load libraries
library(ggplot2)
library(ggthemes)
library(cowplot)
library(png)

# Create a data frame
data <- data.frame(
  Sources = c("Collision - Building glass", "Collisions - Communication towers",
           "Collisions - Electrical lines", "Collision - Vehicles",
           "Collisions - Land-based Wind Turbines", "Electrocutions",
           "Poison", "Cats", "Oil Pits"),
  Medianbirdmortality = c(599000, 6600000, 25500000, 214500000, 234012, 5600000,
          72000000, 2400000000, 750000),
  stringsAsFactors = TRUE
)

# By default ggplot the levels of categorical variables
# Let us sort the df based on median mortality values
data$Sources <- reorder(data$Sources, data$Medianbirdmortality)

# Stop using e notation
options(scipen=10000)

plot <- ggplot(data,
               aes(x = Sources, y = Medianbirdmortality)) +
  geom_bar(stat = "identity",
           fill = ifelse(data$Medianbirdmortality < 2300000000, "#77bd00", "#d68571")) +
          
  geom_text(aes(x = Sources, label = Medianbirdmortality),
            hjust = ifelse(data$Medianbirdmortality < 2300000000, -0.1, 1.1)) +
  theme_wsj() +
  coord_cartesian(clip = "on") +
  coord_flip() +
  
  labs(title = 'Wind Turbines are not Killing Fields for Birds ',
       subtitle = 'Annual estimated bird mortality from selected antropogenic causes in the US (Median)',
       caption = 'Source: US Fish and Wildlife service as of 2017') + 
  
  theme(axis.title.x = element_blank(),
        axis.ticks.x = element_blank(),
        axis.text.x = element_blank(),
        panel.grid.major = element_blank(),
        plot.title.position = "plot",
        plot.caption = element_text(size = 12),
        plot.subtitle = element_text(size = 10),
        plot.title = element_text(size = 20))

# Add images to ggplot image
wind_mill <- readPNG('Wind turbines cats and birds/wind_turbine.png')
bird <- readPNG('Wind turbines cats and birds/bird.png')
cat <- readPNG('Wind turbines cats and birds/cat.png')

ggdraw(plot) +  draw_image(wind_mill, x = .25, y = -0.1, scale = 0.65) +
  draw_image(bird, x = .28, y = 0.02, scale = 0.05) + 
  draw_image(cat, x = .4, y = -0.33, scale = 0.2)

# Saving the Viz
ggsave("Wind turbines cats and birds/Birds_Cats_Turbines.png",
       width = 12, height = 6,
       bg = 'white',
       dpi = 600)