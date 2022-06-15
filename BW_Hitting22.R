library(tidyverse)
library(dplyr)

hitting22 = read.csv(file.choose())

hitting22 %>%
  filter(AB > 25) -> hitting22

hitting22$OPS = hitting22$OBP + hitting22$SLG

hitting22$ISO = round((hitting22$X2B + (2*hitting22$X3B) + 
                         (3*hitting22$HR))/ hitting22$AB, 3)

# Does not include IBB (inflated result by unknown quantity)
hitting22$x1B = hitting22$H - hitting22$X2B - hitting22$X3B - hitting22$HR

hitting22$wOBA = round(((.69*hitting22$BB) + (.72*hitting22$HBP) + 
                          (0.89*hitting22$x1B) + (1.27*hitting22$X2B) + 
                          (1.62*hitting22$X3B) + (2.1*hitting22$HR))/
                          (hitting22$AB + hitting22$BB + hitting22$HBP+ hitting22$SF),3)
#

hitting22$BB_to_K = round(hitting22$BB / hitting22$SO, 2)

hitting22$PA = hitting22$AB + hitting22$SF + hitting22$SH + hitting22$BB + hitting22$HBP

hitting22$K_rate = round(100 * (hitting22$SO / hitting22$PA), 1)

hitting22$BB_rate = round(100 * (hitting22$BB / hitting22$PA), 1)

write.csv(hitting22, "BigWestHitting22.csv", row.names=FALSE)
