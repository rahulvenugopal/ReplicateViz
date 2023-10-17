# Learn data story telling
# taught by Albert Rapp

# Load libraries
library(tidyverse)

# create the datset
dat <- tibble(
  id = 1:19,
  fulfilled = c(803, 865, 795, 683, 566, 586, 510, 436, 418, 364, 379, 372, 374, 278, 286, 327, 225, 222, 200),
  accuracy = c(86, 80, 84, 82, 86, 80, 80, 93, 88, 87, 85, 85, 83, 94, 86, 78, 89, 88, 91),
  error = c(10, 14, 10, 14, 10, 16, 15, 6, 11, 7, 12, 13, 8, 4, 12, 12, 7, 10, 7),
  null = 100 - accuracy - error
) %>% 
  mutate(across(accuracy:null, ~. / 100))
dat