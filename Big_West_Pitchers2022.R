library(dplyr)
library(tidyverse)

hitting22 = read.csv(file.choose())
  
sp22 = read.csv(file.choose())

pitching22 = read.csv(file.choose())

pitching22$IP_outs = round(pitching22$IP * 3)

### FIP
total_ER = sum(pitching22$ER)
total_IP = round(sum(pitching22$IP_outs) / 3, 2)
total_HR = sum(pitching22$HR)
total_BB = sum(pitching22$BB)
total_HBP = sum(pitching22$HBP)
total_K = sum(pitching22$SO)

league_ERA = round((total_ER / total_IP) * 9, 2)


# FIP Constant = lgERA – ( ((13*lgHR)+(3*(lgBB+lgHBP))-(2*lgK)) /lgIP)
FIP_constant = league_ERA - (((13*total_HR)+(3*(total_BB+total_HBP))-(2*total_K)) /total_IP)


# FIP = ((13*HR)+(3*(BB+HBP))-(2*K))/IP + constant
pitching22$FIP = round((((13*pitching22$HR)+(3*(pitching22$BB+pitching22$HBP))-(2*pitching22$SO))/(round(pitching22$IP_outs / 3, 2)) ) + FIP_constant, 2)

#Strikeouts Per Walks
pitching22$SO_BB = round(pitching22$SO / pitching22$BB, 2)

pitching22$ERA_plus = round((100 * (league_ERA/pitching22$ERA)))

pitching22$WHIP = round((pitching22$SO + pitching22$BB)/(round(pitching22$IP_outs / 3, 2)), 3)


pitching22$H9 = round(9 * ((pitching22$H)/(round(pitching22$IP_outs / 3, 2))), 1)
pitching22$HR9 = round(9 * ((pitching22$HR)/(round(pitching22$IP_outs / 3, 2))), 1)
pitching22$BB9 = round(9 * ((pitching22$BB)/(round(pitching22$IP_outs / 3, 2))), 1)
pitching22$SO9 = round(9 * ((pitching22$SO)/(round(pitching22$IP_outs / 3, 2))), 1)

pitching22$K_rate = round((pitching22$SO/pitching22$BF) * 100,1) 
pitching22$BB_rate = round((pitching22$BB/pitching22$BF) * 100,1)

#K% - BB%
pitching22$K_BB_rate = pitching22$K_rate - pitching22$BB_rate



