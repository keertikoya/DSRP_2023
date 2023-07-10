2 + 2

number<-4
number

number + 1
number #4

number = number + 1
number #5

# this is a comment

# click on the arrow on the side to expand
# R Objects ####
ls() #print the names of all objects
rm("object name") #removes object from environment

number <- 5
decimal <- 1.5

letter <- "a"
word <-"hello"

logic <- TRUE
logic2 <- F #understands that means false

#types of variables
class(number)
class(decimal) #numeric

class(letter)
class(word) #character

class(logic) #logical

# there is more variation in types
typeof(number) #double
typeof(letter) #character

# can change the type of an object
as.character(number)
as.integer(number)
as.integer(decimal) # truncates

# round numbers
round(decimal) #2
round (22/7)
?round #to learn more about a func

round(238.123123, digits = 3) #digits rounds to decimal place
round (22/7, 2)

ceiling(22/7) #always rounds up
floor(22/7) #always rounds down

as.integer("hello") #returns NA
word_as_int <- as.integer("hello")

# NA values
NA + 5 

#naming
name <- "Peter"
#NAME, n.a.m.e, n_a_m_e

#things that don't work
n+ame <-"Paul"
3name <- "Jorje"
name3 <- "this works tho"

## illegal naming characters:
# starting w a number or underscore
# operators: + - / *
# conditionals: & | < > !
# others: \ , spaces

n <- ame <- "test" #they both get test


# good naming conventions
camelCase <- "start w capital letter"
snake_case <- "underscores between"



# Object manipulation ####
number
number + 7

decimal
number + decimal

name
paste(name, "Parker","is","spiderman") #concatenates character vectors
paste0(name,"Parker") #no space

paste(name,number) #join chars and nums
logic <- T
paste0(name,logic)

letter
paste(name, "is", letter, number, "year old", logic, "friend")

paste("Programming", "with", "R", sep="_")

?grep
food <- "watermelon"
grepl("me",food) #looks for me in watermelon
sub("me","you",food)
sub("me","",food)




# Vectors ####

#make a vector of numerics
numbers <- c(2,4,6,8,10)
range_of_vals <- 1:5 #all ints 1-5
5:10 # all integers 5 to 10

seq(2,10,2) # from 2 to 10 by 2s
seq(1,10,2) # odd numbers between 1 and 10


rep(3,5) repeat 3 5x
rep(c(1,2),5) #repeats 1,2 5x

# how can we get all the values between 1 and 5 by 0.5?
seq(from=1,to=5,by=0.5)

rep(1:2,each=3) # 1 1 1 2 2 2

#make a vector of characters
letters <- c("a","b","c")
paste("a","b","c") #paste() is different from c()

letters <- c(letters,"d")
letter
letters <- c(letters,letter)
letters
letters <- c("x",letters,"w")

# vector of random numbers between 1 and 20
numbers <- 1:20
five_nums <- sample(numbers, 5)

five_nums <-sort(five_nums)
rev(five_nums) # reverse list

fifteen_nums <- sample(numbers,15,replace = T)
fifteen_nums <- sort(fifteen_nums)
length(fifteen_nums) # length of a vector
unique(fifteen_nums) # what unique values in vector

table(fifteen_nums) # unique values and how many of each

fifteen_nums + 5 # every num increased by 5

nums1 <- c(1,2,3)
nums2 <- c(4,5,6)
nums1+nums2

nums3 <- c(nums1,nums2)
nums3 + nums1 #recycles nums1 to add to nums3
nums3+nums1 + 1

# what is the difference?
sum(nums3 + 1) # sum of all (nums3+1) values
sum(nums3) + 1 # sum of all nums3 values + 1

# vector indexing
numbers
numbers[1] # indexing starts with 1 NOT 0
numbers[1:5]
numbers[c(3,5,6)]
i <- 5
numbers[i]


# Datasets ####

?mtcars # the dataset we chose
mtcars # prints ENTIRE dataset

View(mtcars) # view entire dataset in new tab

summary(mtcars) #info about spread of each var
str(mtcars) #preview the structure of dataset

names(mtcars) #names of variables
head(mtcars)

# pull out individual variables as vectors
mpg <- mtcars[,1] # blanks means "all." All rows, first column
mtcars[2,2] # value at second row, second column
mtcars[3,] # third row, all columns

# first 3 columns
mtcars[,1:3]

# use the names to pull out columns
mtcars$gear # pull out "gear" column
mtcars[,c("gear","mpg")] # pull out gear and mpg columns

sum(mtcars$gear) # sum of all gears










# Statistics ####
View(iris)
iris

first5 <- iris$Sepal.Length[1:5]
mean(first5)
mean(iris$Sepal.Length)

median(first5)
median(iris$Sepal.Length)

range(first5)
max(first5) - min(first5)
max(iris$Sepal.Length) - min(iris$Sepal.Length)

var(first5)
var(iris$Sepal.Length)

IQR(first5)
quantile(first5, 0.25)
quantile(first5, 0.75)

# outliers
quantile(first5, 0.25) - 1.5 * IQR(first5)
quantile(first5, 0.75) + 1.5 * IQR(first5)

s1 <- iris$Sepal.Length
as.numeric(quantile(s1, 0.25) - 1.5 * IQR(s1))
quantile(s1, 0.25) + 1.5 * IQR(s1)

# subsetting vectors
first5
first5 < 4.75
first5[first5 < 4.75]

values <- c(first5,3,9)
upper <- quantile(values, 0.75) + 1.5 * IQR(values)
lower <- quantile(values, 0.25) - 1.5 * IQR(values)

# removes outliers
values[values > lower & values < upper] # keeps values lower than upper and higher than lower

values_no_outliers <- values[values > lower & values < upper]
values_no_outliers






# Conditionals ####
x <- 5

x < 3
x > 3
x == 3
x == 5
x != 3

numbers <- 1:5

numbers < 3
numbers == 3

numbers[1]
numbers[c(1,2)]
numbers[1:2]

numbers[numbers < 3]

lower <- 3
upper <- 4

# pull out only outliers
numbers[numbers < lower]
numbers[numbers > upper]

# combine with | (or) to FIND OUTLIERS
numbers[numbers < lower | numbers > upper]

# use & to get all values NOT outliers
numbers[numbers >= lower & numbers <= upper]

# using & with outlier thresholds DOES NOT work
numbers[numbers < lower & numbers > upper]

# NA values
NA # unknown
NA + 5 # still NA

sum(1,2,3,NA) # returns NA if any value is NA
sum(1,2,3,NA,na.rm+t) # will calc sum w/o NAs





