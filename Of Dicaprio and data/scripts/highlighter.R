ggplot(df, aes(x = Years, y = Leo_age)) + 
  
  geom_point(size = 4,
             pch = 21,
             fill = "#0a001e",
             color = "#ff7400") +
  
  # highlight age 25
  gghighlight(Leo_age == 25, label_key = Leo_ag) # keeping the key as a wrong text