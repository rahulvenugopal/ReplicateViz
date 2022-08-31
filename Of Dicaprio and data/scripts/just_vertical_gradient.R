gf_data <- df_raw %>% select(-Leo_age)

vals <- lapply(gf_data$GF_age, function(y) seq(0, y, by = 0.01))
# the 0.01 controls the smoothness of the bar
y <- unlist(vals)
mid <- rep(gf_data$Years, lengths(vals))

d2 <- data.frame(x = mid - 0.3, xend = mid + 0.2, y = y, yend = y)

middlepart <- ggplot(data = d2, aes(x = x, xend = xend, y = y, yend = yend, color = y)) +
  geom_segment(size = 1) +
  scale_color_gradient2(low = "#083048", 
                        mid = "#0898a2", 
                        high = "#02ecee", 
                        midpoint = 12.5)