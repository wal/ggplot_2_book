library(tidyverse)
library(precis)

temp_data = read.csv("misc/averageTemperatureByMonth.csv")
temp_data$month = factor(df$month, month.name)
precis(temp_data)

ggplot(temp_data, aes(x = month, y = aveTemperature)) + 
  geom_line( ) + ggtitle("Temp by month")


ggplot(aes(x = month, y = aveTemperature, group=1), data = df) + 
  geom_line( ) + 
  ggtitle("Temperature by month")


ggplot(temp_data, aes(x = as.numeric(month), y = aveTemperature)) + 
  geom_line( ) + ggtitle("Temp by month")

