library(tidyverse)


## The Least Squares Method
 
 
bill <- c(34, 108, 64, 88, 99, 51)
tip <- c(5, 17, 11, 8, 14, 5)



df <- data.frame(bill,tip)

ggplot(df, aes(bill, tip)) + 
  geom_point() + 
  geom_smooth(method = "lm", se = FALSE, color = "yellow") +
  ?geom_hline()

cor(df$bill, df$tip)


# The Centroid - The best line will pass through this
bill_mean <- mean(df$bill)
tip_mean <- mean(df$tip)


model <- lm(bill ~ tip, data = df)


df_deviations <- df %>% mutate(bill_deviation = bill - bill_mean, 
              tip_deviation = tip - tip_mean,
              deviation_product = bill_deviation * tip_deviation,
              bill_deviation_squared = bill_deviation ^ 2)



sum_deviation_products <- sum(df_deviations$deviation_product)
sum_bill_deviations <- sum(df_deviations$bill_deviation_squared)

# slope
slope <- sum_deviation_products/ sum_bill_deviations

# intercept
intercept <- tip_mean - (b1 * bill_mean)


slope
intercept

model <- lm(tip ~ bill, data = df)
coef(summary(model))

names(model)

model$coefficients
model$residuals
model$effects
model$rank
model$fitted.values
model$assign
model$qr
model$df.residual
model$xlevels
model$call
model$terms
model$model





summary(model)



