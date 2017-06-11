library(tidyverse)


## 2.2.1 Exercises
# Q1
str(mpg)
summary(mpg)
dim(mpg)
head(mpg)
names(mpg)

# Q2 - http://ggplot2.tidyverse.org/reference/#section-data
# Q3 - https://en.wikipedia.org/wiki/Fuel_economy_in_automobiles
# Q4
# Manufacturers by model count
mpg %>% 
  group_by(manufacturer) %>% 
  summarize(models = n_distinct(model)) %>% 
  arrange(desc(models))

# Models by variation count
mpg %>% 
  group_by(manufacturer, model) %>% 
  summarize(variations = n()) %>% 
  arrange(desc(variations))

# Models without drive train in model name
library(stringr)
mpg %>% 
  mutate(non_dt_model = str_replace(model, ' .wd$', '')) %>%
  group_by(manufacturer, non_dt_model) %>% 
  summarize(variations = n()) %>% 
  arrange(desc(variations))



# 2.3
ggplot(mpg, aes(displ, hwy)) +
  geom_point()

## 2.3.1 Exercises
# Q1
ggplot(mpg, aes(cty, hwy)) + geom_point() + geom_line()

# Q2 
ggplot(mpg, aes(model, manufacturer)) + geom_point()
# Show manufacturers with min cty
min_cty_by_manufacturer <- mpg %>% 
  group_by(manufacturer) %>% 
  summarize(min_cty = min(cty)) %>% 
  arrange(desc(min_cty))
ggplot(min_cty_by_manufacturer, aes(manufacturer, min_cty)) + geom_point()


# Q3
ggplot(mpg, aes(cty, hwy)) + geom_point()
ggplot(diamonds, aes(carat, price)) + geom_point()
ggplot(economics, aes(date, unemploy)) + geom_line()
ggplot(mpg, aes(cty)) + geom_histogram()


ggplot(mpg, aes(displ, cty, color = class)) + geom_point()

ggplot(mpg, aes(displ, hwy)) + geom_point(aes(color = 'blue'))
ggplot(mpg, aes(displ, hwy)) + geom_point(color = 'blue')


## 2.4.1 Exercises

# Question 1

# Continuous values
ggplot(mpg, aes(displ, cty, color = displ)) + geom_point()
ggplot(mpg, aes(displ, cty, shape = displ)) + geom_point() # Error: A continuous variable can not be mapped to shape
ggplot(mpg, aes(displ, cty, size = displ)) + geom_point()
# Size and color together for continuous variable 
ggplot(mpg, aes(displ, cty, size = displ, color = displ)) + geom_point()

# Categorical Value
ggplot(mpg, aes(displ, cty, color = drv)) + geom_point()
ggplot(mpg, aes(displ, cty, shape = drv)) + geom_point()
ggplot(mpg, aes(displ, cty, size = drv)) + geom_point()

# Size and color together for categorical variable
ggplot(mpg, aes(displ, cty, size = drv, color = drv)) + geom_point()
# Size, color and shape for categorical variable
ggplot(mpg, aes(displ, cty, size = drv, color = drv, shape = drv)) + geom_point()


# Question 2
unique(mpg$trans)
ggplot(mpg, aes(displ, cty, shape = trans)) + geom_point() # Too many values (10) - not recommend > 6

# Question 3
ggplot(mpg, aes(drv, hwy)) + geom_point()
ggplot(mpg, aes(drv, cty)) + geom_point()

ggplot(mpg, aes(displ, hwy, color = class)) + geom_point() # useless
ggplot(mpg, aes(class, hwy, color = displ)) + geom_point() # useless

ggplot(mpg, aes(hwy, class, color = hwy)) + geom_point() # useful
ggplot(mpg, aes(class, hwy, size = displ)) + geom_point() # useful


## 2.5.1 Exercisses
# Question 1
ggplot(mpg, aes(hwy, class)) + geom_point()+ facet_wrap(~hwy) # 27 Plots
ggplot(mpg, aes(hwy, class)) + geom_point()+ facet_wrap(~cyl) # 4 Plots

# Question 2
ggplot(mpg, aes(hwy, cyl)) + geom_point() + facet_wrap(~displ) # 35 Plots
ggplot(mpg, aes(displ, hwy)) + geom_point()
ggplot(mpg, aes(displ, hwy)) + geom_point() + facet_wrap(~cyl) # Effect is most obvious for 4 cyl vehicles ?

# Question 3
ggplot(mpg, aes(hwy, cyl)) + geom_point() + facet_wrap(~displ, nrow=10) # 35 Plots in 10 rows
ggplot(mpg, aes(hwy, cyl)) + geom_point() + facet_wrap(~displ, ncol=2) # 35 Plots in 2 cols

ggplot(mpg, aes(hwy, cyl)) + geom_point() + facet_wrap(~displ) # 35 Plots 
ggplot(mpg, aes(hwy, cyl)) + geom_point() + facet_wrap(~displ, scales='free') # shows scales on each plot
ggplot(mpg, aes(hwy, cyl)) + geom_point() + facet_wrap(~displ, scales='free_x') # shows scales on x axis
ggplot(mpg, aes(hwy, cyl)) + geom_point() + facet_wrap(~displ, scales='free_y') # shows scales on y axis

# 2.6

# 2.6.1 - Smoother
ggplot(mpg, aes(displ, hwy)) + geom_point() + geom_smooth() # method = loess
ggplot(mpg, aes(displ, hwy)) + geom_point() + geom_smooth(se = FALSE) # remove confidence interval

ggplot(mpg, aes(displ, hwy)) + geom_point() + geom_smooth(se = FALSE, span = 0.2)
ggplot(mpg, aes(displ, hwy)) + geom_point() + geom_smooth(se = FALSE, span = 1)

library(mgcv)
ggplot(mpg, aes(displ, hwy)) + geom_point() + geom_smooth(method = 'gam', formula = y ~ s(x)) # gam

# Linear model
ggplot(mpg, aes(displ, hwy)) + geom_point() + geom_smooth(method = 'lm')


# 2.6.2 - Boxplot
ggplot(mpg, aes(drv, hwy)) + geom_point()
ggplot(mpg, aes(drv, hwy)) + geom_point() + geom_jitter()
ggplot(mpg, aes(drv, hwy)) + geom_boxplot()
ggplot(mpg, aes(drv, hwy)) + geom_violin() # interestig - widest at highest count part

# 2.6.3 histogram
ggplot(mpg, aes(hwy)) + geom_histogram()
ggplot(mpg, aes(hwy)) + geom_freqpoly()

# 2.6.4 histogram
ggplot(mpg, aes(hwy)) + geom_histogram(binwidth = 2)
ggplot(mpg, aes(hwy)) + geom_freqpoly(binwidth = 5)
ggplot(mpg, aes(hwy)) + geom_density()


ggplot(mpg, aes(displ, color = drv)) + geom_freqpoly(binwidth=0.5)
ggplot(mpg, aes(displ, fill=drv)) + geom_histogram(binwidth=0.5) + facet_wrap(~drv, ncol=1)

names(mpg)

# 2.6.4 Bar Charts
ggplot(mpg, aes(manufacturer)) + geom_bar()

drugs <- data.frame(
  drug = c('a', 'b', 'c'),
  effect = c(4.2,9.7,6.1)
)

ggplot(drugs, aes(drug, effect)) + geom_bar() # Error: stat_count() must not be used with a y aesthetic.
ggplot(drugs, aes(drug, effect)) + geom_bar(stat = 'identity')

# 2.6.5 Line and path plots

ggplot(economics, aes(date, unemploy/pop))  + geom_line()
ggplot(economics, aes(date, uempmed))  + geom_line()

ggplot(economics, aes(unemploy/pop, uempmed)) + geom_path() + geom_point()
year <- function(x) as.POSIXlt(x)$year + 1980
ggplot(economics, aes(unemploy/pop, uempmed)) + geom_path(color = 'grey50') + geom_point(aes(color = year(date)))

# Exercises 2.6.6
# Q1

ggplot(mpg, aes(cty, hwy)) + geom_point() # Problem is overplotting ?
ggplot(mpg, aes(cty, hwy)) + geom_point() + geom_jitter()
ggplot(mpg, aes(cty, hwy)) + geom_bar(stat = 'identity') # solution ? 

sort(unique(mpg$class))






# Q2
levels(mpg$class) = NULL
ggplot(mpg, aes(class, hwy)) + geom_boxplot() 
levels(mpg$class) = sort(unique(mpg$class))
ggplot(mpg, aes(class, hwy)) + geom_boxplot() # Uses levels order from mpg data.frame
ggplot(mpg, aes(reorder(class, hwy, hwy))) + geom_boxplot() # default mean
ggplot(mpg, aes(reorder(class, hwy, min), hwy)) + geom_boxplot()
ggplot(mpg, aes(reorder(class, hwy, max), hwy)) + geom_boxplot()
ggplot(mpg, aes(reorder(class, hwy, median), hwy)) + geom_boxplot()
ggplot(mpg, aes(reorder(class, hwy, mean), hwy)) + geom_boxplot()


# Q3
ggplot(diamonds, aes(carat)) + geom_histogram()
ggplot(diamonds, aes(carat)) + geom_histogram(binwidth = 1)
ggplot(diamonds, aes(carat)) + geom_histogram(binwidth = 0.5)
ggplot(diamonds, aes(carat)) + geom_histogram(binwidth = 0.25)
ggplot(diamonds, aes(carat)) + geom_histogram(binwidth = 0.2)
ggplot(diamonds, aes(carat)) + geom_histogram(binwidth = 0.175)
ggplot(diamonds, aes(carat)) + geom_histogram(binwidth = 0.15) # Best!
ggplot(diamonds, aes(carat)) + geom_histogram(binwidth = 0.125)
ggplot(diamonds, aes(carat)) + geom_histogram(binwidth = 0.1)

# Q4
ggplot(diamonds, aes(price)) + geom_histogram(binwidth=1000) # nice effect
ggplot(diamonds, aes(price, color = cut)) + geom_freqpoly(binwidth=1000)

# Q5
ggplot(diamonds, aes(price, cut)) + geom_violin() # interesting
# geom_violin, geom_freqpoly, color astethic, geom_histogram, faceting

# Q6
g <- ggplot(mpg, aes(class))
# Number of cars in each class:
g + geom_bar()
# Total engine displacement of each class
g + geom_bar(aes(weight = displ))


# 2.7
ggplot(mpg, aes(cty, hwy)) + geom_point()
ggplot(mpg, aes(cty, hwy)) + geom_point(alpha = 1/3)
ggplot(mpg, aes(cty, hwy)) + geom_point(alpha = 1/3) + xlab('X-LAB') + ylab('Y-LAB')
ggplot(mpg, aes(cty, hwy)) + geom_point(alpha = 1/3) + xlab(NULL) + ylab(NULL)

ggplot(mpg, aes(cty, hwy)) + geom_jitter(width = 0.25)
ggplot(mpg, aes(cty, hwy)) + geom_jitter(width = 0.25) + xlim('f', 'r') + ylim(20, 30)







