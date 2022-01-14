# Replicate a visualisation from climate change communication
# My colleague asked me if I can replicate one viz using R
# Viz to replicate the entire thing
# https://climatecommunication.yale.edu/wp-content/uploads/2020/10/SixAm_2020_bubbles-1.png
# author@ Rahul Venugopal on 14th January 2022

# Let it begin -----------------------------------------------------------------
# Loading libraries
library(reshape2)
library(ggplot2)
library(ggtext)

# Creating the data variables
cell <- c(26,28,20,7,11,7)
order_label <- c("Alarmed", "Concerned","Cautious","Disengaged",
                 "Doubtful","Dismissive")
percentages <- c("26%","28%","20%","7%","11%","7%")

# create the dataframe
df <- data.frame(cell, order_label, percentages)

# setting up the color palette
# used https://imagecolorpicker.com/en to pick colors from original viz

color <- c("#066778", "#369c91","#cc9e6c","#818489","#a66c6a","#736076")

# Visualisation
# load logos
logo <- grid::rasterGrob(png::readPNG("logo.png"))

ggplot(df, aes(x = row.names(df), y = 10)) + 
  
  # control y-axis limits
  scale_y_continuous(limits = c(9.6, 10.15)) + 
  
  # the bubbles
  geom_point(size = cell/1.5, # for controlling bubble sizes (w/o proportion sacrifice)
             color = color) + 
  
  # text above bubbles
  geom_text(aes(label = order_label),
            vjust = -4.5,
            size = 3,
            color = color) +
  
  # percentages inside the bubbles
  # fontface parameter - 1(normal),  # 2(bold), 3(italic), 4(bold.italic)
  geom_text(aes(label = percentages,
            fontface = 2),
            vjust = 0.5,
            size = 1.5,
            color = "#ffffff") + 
  
  # title of the plot and custom setups
  labs(title = "Global Warming's Six Americas",
       caption = 'Visualisation: Rahul Venugopal') + 
  
  theme(plot.title = element_text(size = rel(1.25),
                                  hjust = 0.5),
        plot.caption = element_text(color = "grey40",
                                    size = 5),
        panel.background = element_rect(fill = "#ffffff",
                                        colour = "#ffffff"),
        
        axis.title = element_blank(),
        axis.ticks = element_blank(),
        axis.text = element_blank()) + 
  
  # adding logos
  annotation_custom(logo, xmin = 3.85, xmax = 6.4, ymin = 9.5, ymax = 9.7) + 
  
  # draw the arrow
  annotate("segment", x = 0.625, xend = 6.40, y = 9.85, yend = 9.851,
           colour = "black", size = 0.5, alpha = 0.5,
           arrow = arrow(ends = "both",
                         length = unit(1, "mm"))) + 
  
  # adding texts
  geom_text(
    data = data.frame(x = 0.75, y = 9.71,
                      label = "Highest Belief in Global Warming\nMost Concerned\nMost Motivated"),
    aes(x, y, label = label), alpha = 0.8,
    hjust = 0, vjust = 0,  size = 2,
    # vjust negative values pushes textup
    # hjust larger values pushes towards left
    color = "black") + 
  
  geom_text(
    data = data.frame(x = 6.30, y = 9.71,
                      label = "Lowest Belief in Global Warming\nLeast Concerned\nLeast Motivated"),
    aes(x, y, label = label), alpha = 0.8,
    hjust = 1, vjust = 0,  size = 2, # hjust being 1 gives right alignment
    # vjust negative values pushes text up
    # hjust larger values pushes towards left
    color = "black") + 
  
  # adding the N numbers on left outside the plot
  # this part is to create some empty space and then put text
  # couldn't figure out the trick to unstick text to left side and clipping!
  annotate(geom = "text", x = -0.25, y = 10,
           size = 1.5,
           label = " ") +
  
  annotate(geom = "richtext", x = 0.1, y = 10,
           size = 2,
           label.size = NA,
           label = "<b>April<br>2020</b><br><i>N</i> = 1,029") +

  # prevent clipping 
  coord_cartesian(clip = "off")

# saving the image
ggsave("Global warming replication.png",
       dpi = 600,
       width = 2810,
       height = 1444,
       units = "px",
       type = "cairo-png")