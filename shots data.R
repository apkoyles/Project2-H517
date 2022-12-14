library(data.table)
library(dplyr)

#data
shots = fread(file = 'oldNBA_04_22_Shots.csv')

#check all values of yearSeason (which will be used to filter)
unique(shots$yearSeason)

#create dataframe with the three years that have problems removed
shotsNew = shots %>% filter(!yearSeason %in% c('2020', '2021', '2022'))

summary(shotsNew)

#create df that has only the three problem seasons included
shots_1922 = shots %>% filter(yearSeason %in% c('2020', '2021', '2022'))

summary(shots_1922)

#transform X and Y variables to match with other seasons
shots_1922$locationX = shots_1922$locationX * 10

shots_1922$locationY = (shots_1922$locationY * 10) - 52

summary(shots_1922)

##summary(shots)

#bind the two dataframes together to recreate the original with the transformed data
shotsFinal = shots_1922 %>% bind_rows(shotsNew)

summary(shotsFinal) 

unique(shotsFinal$slugSeason)

#check that the new dataframe is correct
shotsCheck = shotsFinal %>% filter(yearSeason %in% c('2020', '2021', '2022'))

summary(shotsCheck)

#write data to csv for use
##write.csv(shotsFinal, 'shotsFinal_2.csv')

shotsFinal2 = fread(file = 'shotsFinal_2.csv')

##filter for last 10 years and write to csv
shotsFinal3 = shotsFinal2 %>% filter(yearSeason %in% c('2013', '2014', '2015', '2016', '2017', '2018', '2019', '2020', '2021', '2022'))

##write.csv(shotsFinal3, 'shotsFinal_3.csv')

shotsFinal3 = fread(file = 'shotsFinal_3.csv')

##filter out backcourt shots
shotsFinal3 = shotsFinal3 %>% select(-c(V1, V1))

unique(shotsFinal3$zoneRange)

shotsFinal4 = shotsFinal3 %>% filter(!zoneRange %in% 'Back Court Shot')

##check
unique(shotsFinal4$zoneRange)

##write.csv(shotsFinal4, 'shotsFinal_4.csv')
