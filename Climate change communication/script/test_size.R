library(ggplot2)

cells <- c(2.5,5,10,20,40)
df <- data.frame(cells)

p <- ggplot(df, aes(x = row.names(df), y = 1,
                    size = cells)) + 
  geom_point()

p + scale_size_area()


ggsave('compare_area.png',
       dpi = 300,
       width = 10,
       height = 3,
       type = "cairo-png")
	   
# I missed adding the size parameter to the aes in ggplot line !!!