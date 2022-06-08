\name{hello}
\alias{hello}
\title{Hello, World!}
\usage{
# Unit 1
#===========================================================================

# Replacement using Mean, Median and value
# Read the data
imp <- read.csv("D:/ISDC Work/Content/R/Datasets/imp.csv")
View(imp)
# replacement by mean
imp$variable1[is.na(imp$variable1)] <- mean(imp$variable1, na.rm = T)
View(imp)
# replacement by median
imp$variable2[is.na(imp$variable2)] <- median(imp$variable2, na.rm = T)
View(imp)
# replacement using a particular value
imp$variable3[is.na(imp$variable3)] <- 78
View(imp)

# KNN Imputation
# install VIM package for kNN function
install.packages('VIM')
library(VIM)
# Read the data
imp <- read.csv("D:/ISDC Work/Content/R/Datasets/imp.csv")
View(imp)
# performing kNN imputation
imp_mod <- kNN(imp)
View(imp_mod)
# subsetting the data to make it like original without extra columns
imp <- imp_mod[1:3]
# final answer
View(imp)

# Complete Cases
# Read the imp data
imp <- read.csv("D:/ISDC Work/Content/R/Datasets/imp.csv")
View(imp)
# applying complete.cases function
imp[complete.cases(imp), ]
# Practice case
# read the framingham data and then apply complete cases
fram <- read.csv("D:/ISDC Work/Content/R/Datasets/framingham.csv")
str(fram)
fram_cc <- fram[complete.cases(fram), ]
str(fram_cc)

# Logical Operations
x <- FALSE
y <- TRUE
# AND/OR/NOT Operation (Boolean/Binary/Logical - Operations/Connectives)
x & y
x | y
!x
# trying with different values
x <- T
y <- T
x & y
x | y
!y
# Simple Decision Making using arithmetic operator
a <- 6
b <- 18
if(a < b){
  print("b is greater than a")
}
# example of logical argument within if-block
x <- T
y <- F
if(!x == F){
  print(x)
}
# if-else block with logical arguments
x <- T
y <- F
if(x & y == T){
  print("both x and y are True")
}else{
  print("both x and y are not True")
}

# Factors (Categories)
# Unordered Factor Levels
gender <- factor(c("female", "male", "female", "male", "female"))
gender
# printing the level of factor variable
levels(gender)
# counting the number of levels
nlevels(gender)

# Ordered Factor Levels
# creating a simple factor then putting hierarchy/order
temperature <- factor(c("highest", "high", "medium", "low", "lowest", "high",
                        "low", "lowest", "medium"))
levels(temperature)
# unordered factor will not execute min/max functions as there is no hierarchy
# or importance
min(temperature)
max(temperature)
temperature_ord <- factor(temperature, levels = c("lowest", "low", "medium",
                                                  "high", "highest"), ordered = T)
temperature_ord
# ordered factor will execute min/max functions as there is a hierarchy
# or importance
min(temperature_ord)
max(temperature_ord)

# another example - feedback factor variable
feedback <- factor(c("satisfactory", "satisfactory", "good", "good", "good",
                     "bad", "best", "best", "best", "cant_comment"))
feedback
nlevels(feedback)
feedback_ordered <- factor(feedback, levels = c("cant_comment", "bad",
                                      "satisfactory", "good", "best"), ordered = T)
feedback_ordered
nlevels(feedback_ordered)
# counting the number of values for each category in the given data
table(feedback_ordered)
table(temperature_ord)

# working on an actual dataset
breast_cancer <- read.csv("C:/Users/Sachin Tripathi/Desktop/breast-cancer.csv")
View(breast_cancer)
str(breast_cancer)
breast_cancer$Class <- as.factor(breast_cancer$Class)
str(breast_cancer)
# automating using a loop
for(i in colnames(breast_cancer)){
  breast_cancer[i] = factor(breast_cancer[[i]])
}
str(breast_cancer)

# removing unnecessary dataframes from R
# list command -> lists all the data variables which are in R, currently
ls()
# remove command can be used for removing the said data variable
rm(breast.cancer)
# multiple removal using comma separation
rm(a, abc, x, y)

# Outlier Analysis (Revision)
# read the data
cereals <- read.csv('D:/ISDC Work/Content/R/Datasets/Cereals.csv')
View(cereals)
# visualizing outlier using a boxplot for the entire data
boxplot(cereals[4:12], col = 'royalblue')
# calories columns shows maximum number of outliers
# finding the lower and upper bounds
col1 <- cereals$calories
boxplot(col1)
lb <- quantile(col1, 0.25) - 1.5*IQR(col1)
ub <- quantile(col1, 0.75) + 1.5*IQR(col1)
lb
ub
# treating outliers using lb and ub
col1[col1 < lb] <- lb
col1[col1 > ub] <- ub
# checking
boxplot(col1)

# apply family
# apply function works on a matrix only
mat1 <- matrix(c(1:10, 31:40), nrow = 5, ncol = 4)
mat1
# apply function uses 3 parameters
# name of the matrix, 1/2 for row/col and the function
apply(mat1, 1, mean)
apply(mat1, 2, sum)
# lapply works on a list
ls <- list(x = 1:5, y = 10:15, z = 2:7)
ls
lapply(ls, sum)
# sapply
sapply(ls, sum)
# tapply
View(iris)
tapply(iris$Sepal.Length, iris$Petal.Length, mean)
tapply(cs2m$BP, cs2m$DrugR, median)

# Unit 2
#===========================================================================

# Descriptive Statistics
vec <- c(1, 3, 3, 3, 5, 5, 18, 27, 17)
# measures of central tendency
mean(vec)
median(vec)
cereals <- read.csv('D:/ISDC Work/Content/R/Datasets/Cereals.csv')
mean(cereals$fiber)
median(cereals$fiber)
# creating a function to compute mode
get_mode <- function(var){
  uniq_val <- unique(var)
  uniq_val[which.max(tabulate(match(var, uniq_val)))]
}
# calling the function - for a vector
get_mode(vec)
# calling the function - for a column in a dataframe
get_mode(cereals$calories)
# measures of variability
vec <- c(12, 15, 8, 18, 20)
sd(vec)
var(vec)
# manual computation of sd/var - population
sd_pop <- sqrt(sum((vec - mean(vec))^2/(length(vec))))
sd_pop
# skewness & kurtosis
vec <- c(12, 15, 8, 18, 20, 24, 15, 10, 4, 24, 29)
hist(vec)
# calculating mean and median to justify skewness (+ve or -ve)
mean(vec)
median(vec)
# we find that mean > median which means the distribution is
# +vely skewed
d_fun <- dnorm(vec, mean = mean(vec), sd(vec))
hist(vec, prob = T, ylim = c(0, max(d_fun)), col = 'royalblue')
lines(density(vec), lwd = 3, col = 'red')
# install.packages('moments')
library(moments)
skewness(vec)
kurtosis(vec)
# finding skewness and kurtosis for a dataframe column
skewness(cereals$carbo, na.rm = T)
kurtosis(cereals$carbo, na.rm = T)
boxplot(cereals$carbo)
# inter-quartile range
IQR(cereals$carbo, na.rm = T)
# histogram
cs2m <- read.csv("D:/ISDC Work/Content/R/Datasets/cs2m.csv")
# setting the chart area to have 2 rows 2 cols ie. 4 charts
par(mfrow = c(2, 2))
hist(cs2m$BP, col = 'royalblue', main = 'BP')
hist(cs2m$Age, col = 'gold', main = 'Age')
hist(cs2m$Chlstrl, col = 'chartreuse', main = 'Cholesterol')
hist(cs2m$Prgnt, col = 'brown1', main = 'Pregnancy')
# barchart
# setting the chart area to have 1 row 1 col ie. 1 chart
par(mfrow = c(1, 1))
barplot(cs2m$Chlstrl, col = 'chartreuse1', main = 'Cholesterol',
        xlab = 'Row', ylab = 'Value')
# piechart
vec1 <- c(50, 62, 102, 121)
labels <- c('India', 'UK', 'US', 'China')
pie(vec1, labels, col = rainbow(4))
# displaying legend and percentages
#### solve this
per <- round(100*vec1/sum(vec1))
per
pie(vec1, labels = per, col = rainbow(4),
    legend('topright', c('India', 'UK', 'US', 'China'), cex = 0.7))
# stem and leaf diagram
vec <- c(10, 12, 20, 25, 13, 28, 15, 35, 48, 31, 49)
stem(vec)

# Unit 3
#===========================================================================

# Probability - Basics
# Set Theory operations
U = c(1, 2, 3, 4, 10, 11, 12, 15, 21)
A = c(1, 2, 4, 10, 12)
B = c(2, 3, 10, 15)
C = c(10, 15, 21)
# simple operations - union/intersection and set difference
union(A, B)
union(union(A, B), C)
intersect(A, B)
intersect(intersect(A, B), C)
setdiff(A, B)
setdiff(setdiff(A, B), C)
# complement of A
setdiff(U, A)
# complement of B
setdiff(U, B)
# complement of union of A & B
setdiff(U, union(A, B))
# complement of union of A & B & C
setdiff(U, union(union(A, B), C))
# complement of intersection of A & B
setdiff(U, intersect(A, B))
# complement of intersection of A & B & C
setdiff(U, intersect(intersect(A, B), C))

# using sets library
# install.packages('sets')
library(sets)
U = c(1, 2, 3, 4, 10, 11, 12, 15, 21)
A = c(1, 2, 4, 10, 12)
B = c(2, 3, 10, 15)
C = c(10, 15, 21)
# convert the vectors in set format
U = as.set(U)
A = as.set(A)
B = as.set(B)
C = as.set(C)
# performing set operations
set_union(A, B, C)
set_intersection(A, B, C)
set_complement(A, U)
set_complement(set_union(A, B, C), U)

# prob library for probabilistic coding
#install.packages('prob')
library(prob)
# finding the prob of drawing 3 labeled balls from an urn of 4 balls
# replacement and ordering
urnsamples(1:4, size = 3, replace = T, ordered = T)
# finding the prob of drawing 3 labeled balls from an urn of 4 balls
# replacement and without ordering
urnsamples(1:4, size = 3, replace = T, ordered = F)
# finding the prob of drawing 3 labeled balls from an urn of 4 balls
# without replacement and without ordering
urnsamples(1:4, size = 3, replace = F, ordered = F)

# card simulation and prob calculation
s <- cards()
s
subset(s, suit == 'Heart')
subset(s, suit == 'Diamond')
# finding the prob of each card
probspace(s)

# problem - roll 2 dices simultaneously
# see if 2 and 4 values come together (find the prob)
# ordering doesnt matters
r <- rolldie(2)
r
total <- nrow(r)
total
ans <- subset(r, isin(r, c(2, 4), ordered = F))
ans
pr <- nrow(ans)/total
pr

# problem - roll 3 dices simultaneously
# see if 3, 3, 3 values come together (find the prob)
# ordering doesnt matters
r <- rolldie(3)
r
total <- nrow(r)
total
ans <- subset(r, isin(r, c(3, 3, 3), ordered = F))
ans
pr <- nrow(ans)/total
pr

# problem - roll 3 dices simultaneously
# see if 3, 4, 5 values come together (find the prob)
# ordering doesnt matters
r <- rolldie(3)
r
total <- nrow(r)
total
ans <- subset(r, isin(r, c(3, 4, 5), ordered = F))
ans
pr <- nrow(ans)/total
pr

# consider an urn with 10 balls
# there are 7 red and 3 blue balls in the urn
# find the prob based on 3 balls being picked up successively
L <- rep(c('Red', 'Blue'), times = c(7, 3))
L
M <- urnsamples(L, size = 3, replace = F, ordered = F)
M
N <- probspace(M)
N

# rolling 2 dices and finding the prob that 5 doesnt comes
# order = true eg. (5,1) & (1, 5) are two different outcomes
x <- rolldie(2, makespace = T)
x
jx <- subset(x, isin(x, c(5), ordered = T))
jx
jy <- Prob(jx)
1-jy

# 2 rolling dice samples
v1 <- rolldie(2, makespace = TRUE)
v1
# define 2 events -- a and b
# event a = both dice give same number
a <- subset(v1, X1 == X2)
a
# event b = sum of both numbers based on 2 dice >= 8
b <- subset(v1, X1 + X2 >= 8)
b
# finding conditional prob based on event a and b
# finding prob of a when event b has already occurred
Prob(a, given = b)
# finding prob of b when event a has already occurred
Prob(b, given = a)

# shortcut for the above problem
# 2 rolling dice samples
s <- rolldie(2, makespace = TRUE)
s
Prob(s, X1==X2, given = (X1 + X2 >= 8))
Prob(s, X1 + X2 >= 8, given = (X1 == X2))

# manual computation
yts = intersect(a, b)
yts
ytf = Prob(yts)/Prob(b)
ytf

# Toss 3 coins
# events -- 'a' ==> atleast 2 are head -- 2 or more than 2 heads
# events -- 'b' ==> atleast 1 is tail
# prob of event 'a' such that 'b' has already happend
t <- tosscoin(3, makespace = TRUE)
t
ta <- subset(t, isrep(t, vals = 'H', nrep = 1))
ta
tta = setdiff(t, ta)
tta
ta = tta[1:4,]
ta
tb <- subset(t, isrep(t, vals = 'T', nrep = 0))
tb
tb = setdiff(t, tb)
tb
Prob(ta, given = tb)

# shortcut for the above scenario
# Using ISIN
a <- subset(t, isin(t, c("H", "H"), ordered = FALSE))
a
b <- subset(t, isin(t, "T", ordered  = FALSE))
b
Prob(a, given = b)
Prob(b, given = a)

#Bayes Theorem
install.packages("LaplacesDemon")
library(LaplacesDemon)
PrA <- c(0.25,0.50)
PrBA <- c(4/7, 3/8)
#finding P(A|B) using Bayes theorem
BayesTheorem(PrA, PrBA)

# Probability Distributions
# Continuous Prob. Distributions - Normal Dist.
x <- seq(-40, 40, by = 0.1)
x
y <- dnorm(x, mean = 4.5, sd = 10)
y
plot(x, y, col = 'blue')
lines(x,y, col = 'red')

# Cumulative probabilities for Normal Dist.
z <- pnorm(x, mean = 2.5, sd = 0.5)
plot(x, z, col = 'blue')
lines(x, z, col = 'red')

# Discrete Probability Dist -> Binomial Dist.
x <- seq(0, 100, by = 2)
x

y <- dbinom(x, 100, 0.5)
y
plot(x, y)

# What will be the probability of getting 20 heads from 68 coins tosses.
x <- pbinom(20, 68, 0.5)
x

x <- dbinom(20, 68, 0.5)
x

# What is the density function for getting 10 tails when 20 coins are tossed
dbinom(10, 20, 0.5)

pbinom(10, 20, 0.5)

# Create a sequence from -35 to +35 based on a difference of 0.3
# and then find normal dist. cumulative probability with mean = 2 and sd = 0.4
# then plot the curve
t <- seq(-35, 35, by = 0.3)
res <- pnorm(t, mean = 2, sd = 0.4)
plot(t, res)

# take a sequence from -4 to +4 having length of 200
# and then find density function based on normal dist. with mean = 0, sd = 1
# plot the distribution as well
# 68% data dist. +-1 SD
v <- seq(-4, 4, length = 200)
o <- dnorm(v, mean = 0, sd = 1)
plot(v, o, type = 'l', col = 'red', lwd = 3)
v <- seq(-1, 1, length = 100)
o <- dnorm(v)
polygon(c(-1, v, 1), c(0, o, 0), col = 'royalblue')

# 95% data distribution --> +-2 SD
v <- seq(-4, 4, length = 200)
o <- dnorm(v, mean = 0, sd = 1)
plot(v, o, type = 'l', col = 'red', lwd = 3)
v <- seq(-2, 2, length = 100)
o <- dnorm(v)
polygon(c(-2, v, 2), c(0, o, 0), col = 'royalblue')

# Sampling
# you have a population of numbers from 1 to 200
# u have to choose a random sample from the above population
s1 <- sample(seq(1, 200), 5)
s1
s2 <- sample(seq(1, 200), 5)
s2
s3 <- sample(seq(1, 200), 5)
s3

# Sampling distrib.
# outcomes when we roll 2 dices and get the sum of numbers
S <- 2:12
# probability of outcomes in Sample space S
P <- c(1:6, 5:1)/36
P
# set the plotting area to accomodate 2 graphs
par(mfrow = c(1, 2))
probability <- rep(1/6, 6)
probability
barplot(probability, xlab = "D", space = 0,
        ylab = 'Prob',
        main = 'Outcome of a single dice roll', col = 'steelblue')
barplot(P, ylim = c(0, 0.2), space = 0, xlab = 'S',
        ylab = 'Prob',
        main = "Sum of 2 dice rolls", col = 'steelblue')


# Anand is one life insurance salesperson who sells 3 insurances
# in a week. What will be the probability that Anand is able to sell
# 2 or more but less than 5 insurance?
dpois(2, 3) + dpois(3, 3) + dpois(4, 3)

# There are 15 cars crossing a train track per minute on an average per day.
# What will be the probability of having 20 or more cars crossing
# the train track in a particular minute.
ppois(19, lambda = 15, lower = F)

# Everyday 8 babies are born in one hospital on an average per day.
# Find the probability that 10 or more babies are born tomorrow.
ppois(9, lambda = 8, lower = F)

# 8 babies are born in one hospital on an average per day.
# Find the probability that 6, 9 or 12 babies are born tomorrow.
dpois(6, 8) + dpois(9, 8) + dpois(12, 8)

# BINOMIAL DISTRIBUTION EXAMPLES
# 80% of people who adopt dogs are women.
# If 8 dog adoptions happend in 2020 in the month of december,
# find the probability that exactly 6 were women amongst those people.
dbinom(6, size = 8, prob = 0.8)

# 80% of people who adopt dogs are women.
# If 8 dog adoptions happend in 2020 in the month of december,
# find the probability that atmost 3 were women amongst those people.
# course of action for the problem:
# P(0 <= X <= 3) -> P(X = 0) + P(X = 1) + P(X = 2) + P(X = 3)
dbinom(0, size = 8, prob = 0.8) + dbinom(1, size = 8, prob = 0.8)+
  dbinom(2, size = 8, prob = 0.8) + dbinom(3, size = 8, prob = 0.8)

# 80% of people who adopt dogs are women.
# If 8 dog adoptions happend in 2020 in the month of december,
# find the probability that the number of women is greater than equal to 2 and
# less than equal to 5 amongst those people.
# course of action for the problem:
# P(2 <= X <= 5) -> P(X = 2) + P(X = 3) + P(X = 4) + P(X = 5)
dbinom(2, size = 8, prob = 0.8) + dbinom(3, size = 8, prob = 0.8)+
  dbinom(4, size = 8, prob = 0.8) + dbinom(5, size = 8, prob = 0.8)

# Unit 4
#===========================================================================

# Hypothesis Testing
# One-Sample t-Test
t.test(cs2m$Age, mu = 40, conf.level = 0.8)

sc <- read.csv("D:/ISDC Work/Content/R/Datasets/sc.csv")
View(sc)
summary(sc)

sc$city <- as.factor(sc$city)
summary(sc)

View(sc)
model <- aov(sales ~ city, data = sc)
summary(model)
}
\description{
Prints 'Hello, world!'.


}
\examples{
hello()
}
