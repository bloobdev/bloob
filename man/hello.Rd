\name{hello}
\alias{hello}
\title{Hello, World!}
\usage{
# importing ggplot2 using tidyverse
library(tidyverse)
# importing diamonds datasets
data("diamonds")
View(diamonds)

# creating a scatter plot using carat and price columns
# putting cut column as the color parameter
ggplot(diamonds, aes(x = carat, y = price, col = cut)) + geom_point()

# adding a regression line using geom_smooth function
# encapsulating aes inside geom_point function
ggplot(diamonds, aes(x = carat, y = price)) + geom_point(aes(col = cut)) + geom_smooth()

# adding customized labels -> title, x-axis and y-axis
ggplot(diamonds, aes(x = carat, y = price)) + geom_point(aes(col = cut)) + 
  labs(title = "Simple Plot", x = "CARAT", y = "PRICE")

#install.packages('ggthemes')
library(ggthemes)

gg_plot1 <- ggplot(diamonds, aes(x = carat, y = price)) + 
  geom_point(aes(col = cut)) + 
  labs(title = "Simple Plot", x = "CARAT", y = "PRICE")

gg_plot_with_theme <- gg_plot1 + theme_excel_new()
gg_plot_with_theme



df <- data.frame(x = c(5, 6, 7), 
                 y = c(4, 3, 1), 
                 label = c("X","Y","Z"))
p <- ggplot(df, aes(x, y, label = label)) + 
  labs(x = NULL, y = NULL) + # No labels given (Hiding)
  theme(plot.title = element_text(size = 12))  # controling text size
p + geom_point() + ggtitle("point")
p + geom_text() + ggtitle("text")
p + geom_bar(stat = "identity") + ggtitle("bar")
p + geom_tile() + ggtitle("raster")

p + geom_line() + ggtitle("line")
p + geom_area() + ggtitle("area")
p + geom_path() + ggtitle("path")
p + geom_polygon() + ggtitle("polygon")

#======================================================#
# using gapminder data
library(tidyverse)
library(gapminder)
population_sample <- gapminder %>% 
  filter(
    country %in% c("Canada", "China", "United States"), 
    year >= 1997
  ) %>% 
  select(country, year, pop) %>% 
  mutate(pop = pop / 10^6)

View(population_sample)

messy_pop <- population_sample %>% spread(year, pop)
messy_pop

tidy_pop <- gather(messy_pop, 'year', 'pop', -country)
tidy_pop

aes(x = year, y = pop, color = country)

ggplot(tidy_pop) + aes(x = year, y = pop)

ggplot(tidy_pop) + aes(x = year, y = pop) + geom_point()

ggplot(tidy_pop) + aes(x = year, y = pop, color = country) + geom_point()

ggplot(tidy_pop) + aes(x = year, y = pop, color = country) + geom_point() + geom_line()                       

ggplot(tidy_pop) + aes(x = year, y = pop, color = country) + geom_point() + geom_line(aes(group = country))                       

#MIDTERM QESSIONS

# simple exercise
ggplot(gapminder) +
  aes(x = gdpPercap,
      y = lifeExp)

# adding points
ggplot(gapminder) +
  aes(x = gdpPercap,
      y = lifeExp) +
  geom_point()

# telling countries apart
ggplot(gapminder) +
  aes(x = gdpPercap,
      y = lifeExp,
      color = continent) +
  geom_point()

# expanding GDP (left side) - Use log10 for dimentionality reduction
ggplot(gapminder) +
  aes(x = gdpPercap,
      y = lifeExp,
      color = continent) +
  geom_point() +
  scale_x_log10()

#?facet_wrap - #Here it groups data according to continent, wraps all categories into one subplot

ggplot(gapminder) +
  aes(x = gdpPercap,
      y = lifeExp,
      color = continent) +
  geom_point() +
  scale_x_log10() +
  facet_wrap(~ continent) +
  guides(color = "none")

#Reducing overlap by lowering size of each datapoint
ggplot(gapminder) +
  aes(x = gdpPercap,
      y = lifeExp,
      color = continent) +
  geom_point(size = 0.25) +
  scale_x_log10() +
  facet_wrap(~ continent) +
  guides(color = "none")

#checking trend using line
ggplot(gapminder) +
  aes(x = gdpPercap,
      y = lifeExp,
      color = continent) +
  geom_line() +
  geom_point(size = 0.25) +
  scale_x_log10() +
  facet_wrap(~ continent) +
  guides(color = "none")


ggplot(gapminder) +
  aes(x = gdpPercap,
      y = lifeExp,
      color = continent) +
  geom_line() +
  geom_point(size = 0.25) +
  geom_violin() +
  geom_quantile()+
  scale_x_log10() +
  facet_wrap(~ continent) +
  guides(color = "none")

americas =
  gapminder %>%
  filter(
    country %in% c(
      "United States",
      "Canada",
      "Mexico",
      "Ecuador"
    )
  )

#column/bar chart
ggplot(americas) +
  aes(
    x=year,
    y=pop
  ) +
  geom_col()

#Stacked Bar chart
ggplot(americas) +
  aes(
    x=year,
    y=pop,
    fill= country
  ) +
  geom_col()

#dodge bar chart
##position = dodge makes objects side by side instead of overlapping
country1 = readLines(n=4)
strsplit(country1,",")
print(country1)
country2 = gapminder %>%
  filter(
    country %in% c(country1))

ggplot(country2) +
  aes(
    x=year,
    y=pop,
    fill= country
  ) +
  geom_col(
    position = "dodge"
  )


 #free_y used for freeing the axis, y-axis will not be fixed, will change according to values
 ggplot(americas) +
   aes(
     x=year,
     y=pop / 10^6,
     fill = country
     )+
   geom_col(
     position = "dodge"
   ) +
   facet_wrap(~country,
              scales = "free_y") +
   guides(fill = "none")
  
  install.packages('tidyverse')
library(tidyverse)
library(ggplot2)
data("iris")
iris
#plotting a point graph for Iris dataset
ggplot(iris,aes(Sepal.Length,Sepal.Width, colour = Species)) + geom_point()

#Dataset Library for visualization - population data over time
install.packages('gapminder')
library(gapminder)

data("mtcars")
View(mtcars)


#input redirection - redirecting input from a file to an output
mpg%>% filter(year == 1999) #From the mpg data, filter everything with year 1999

#stdin - standard input (keyboard), stdout - standard output (monitor)

#output redirection - redirecting your input to a file rather than your monitor
df_mpg <- mpg%>% #%>% is used to transfer mpg to the filter code
  filter(class%in% c("compact","suv")) %>% 
  filter(manufacturer %in% c("toyota","ford","audi")) %>%
  filter(year == 2008) %>%
  group_by(manufacturer, model) %>%
  sample_n(1)
df_mpg

#importing ggplot2 using tidyverse
library(tidyverse)
#importing diamonds datawsets
data("diamonds")
view(diamonds)

ggplot(diamonds, aes (x = 'carat',y = 'price', col = 'cut')) + geom_point()

#models       
?geom_point

ggplot(diamonds,aes(x = carat,y = price,col = color)) + 

#GUI interface for plotting graphs
install.packages('esquisse')
library(esquisse)
#Running Esquisse
esquisse::esquisser()

ggplot(diamonds) +
  aes(x = carat, y = price, colour = color) +
  geom_point(shape = "diamond", size = 1.5) +
  scale_color_manual(
    values = c(D = "#F8766D",
               E = "#BD9A00",
               F = "#31B425",
               G = "#00C19F",
               H = "#20AFEC",
               I = "#443FFF",
               J = "#5A1BF3")
  ) + theme_dark()
#under geom_smooth, the method used is 'gam' or generalized additive modelling, we can use multiple linear equations can be used to form 1 combined graph
ggplot(diamonds,aes(x = carat,y = price)) + geom_point(aes(col = cut)) + geom_smooth()

ggplot(diamonds,aes(
  x = carat,y = price)) + 
  geom_point(aes(col = cut)) + 
  geom_smooth() + theme_dark() + 
  labs(title = "Simple Plot", x = "Carat", y = "Price") + 
  theme_solarized() 
 
#ggthemes - for different themes
install.packages('ggthemes')
library(ggthemes)

gg_plot1 =  ggplot(diamonds,aes(x=carat,y=price)) +
  geom_point(aes(col=cut)) +
  labs(title = "Simple Plot", x = "Carat", y = "Price")
gg_plot_with_theme = gg_plot1 + theme_economist()
gg_plot_with_theme

gg_plot_with_theme = gg_plot1 + theme_calc()
gg_plot_with_theme

#Theme - Enables consistency in the entire visualizations / representations

# Know which chart to use when

library(gapminder)
library(tidyverse)

#Setting the aesthetic by default is possible in R
##-----------------------------------------------##
df = data.frame(data = iris, x = iris$Sepal.Length,
                y = iris$Petal.Length,
                label = c("Sepal Length","Petal Length"))
p = ggplot(df, aes(x , y, label = label)) +
  labs(x = 'Sepal Length', y = 'Petal Length') + #No Labels Given (Hiding)
  theme(plot.title = element_text(size = 24)) # controlling text size

p + geom_point() + ggtitle("point")
p + geom_text() + ggtitle("text")
p + geom_bar(stat = "identity") + ggtitle("bar")
p + geom_tile() + ggtitle("raster") #look up what raster is

p + geom_line() +ggtitle("line")
p + geom_area() +ggtitle("area")
p + geom_path() + ggtitle("path")
p + geom_polygon() + ggtitle("polygon")

#Mid term Question - Demonstrate 4 to 5 types of geometrical objects
df = data.frame(iris %>% select(Sepal.Length, Petal.Length)%>% sample_n(10),
                label = c("Sepal.Length","Petal.Length")) # Selects random 10 rows
df = data.frame(iris %>% select(Sepal.Length, Petal.Length),
                label = c("Sepal.Length","Petal.Length")) # Selects first 5 rows

p = ggplot(df, aes(Sepal.Length,Petal.Length),label = c("Sepal.Length","Petal.Length")) +
  theme(plot.title = element_text(size = 12))
p + geom_point() + ggtitle("point")
p + geom_text() + ggtitle("text")
p + geom_bar(stat = "identity") + ggtitle("bar")
p + geom_tile() + ggtitle("raster") #look up what raster is

p + geom_line() +ggtitle("line")
p + geom_area() +ggtitle("area")
p + geom_path() + ggtitle("path")
p + geom_polygon() + ggtitle("polygon")


df  
#--------------------------------------#
#Using Gapminder Data
library(tidyverse)
library(gapminder)
