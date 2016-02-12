## Introduction to R
## Breanne Chryst and Sara Bastomski
## CSSSI StatLab
## Feb 19, 2016

##########################################################
## R Basics
##########################################################

## R can be used as a calculator, it works as expected:
2+3
exp(2)
5^(2)
3*2+4
(2*4+1)/2

## The print command:
print("Hello World")

print(5*2-11)

## Assigning a variable
x <- 5 # 5 has now been assigned to the variable x

# the "<-" assigns the value on the right to the name on the left. Made by "alt -"

x

x^2

## Creating a vector:
y <- c(3,7,5,1,2,3,2,5,5) # "c()" concatenates, creating a vector

## Extracting values of a vector:
y[2]

3:5 # the whole numbers from 3 to 5

y[3:5] # extracts the 3rd to 5th elements in the vector y

sub.y <- y[3:5]
sub.y

## Other ways to make vectors:
array(data = 0, dim = 3)

seq(from = 1, to = 4, by = 1)
seq(1,4,0.5)

rep(x = "cat", times = 3)

rep(c("cat", 4, x^(2)), each = 2)

rep(c("cat", 4, x^(2)), times = 2)

## "matrix()" creates a matrix from the values entered:
z <- matrix(y, nrow=3) # This is filled by column
z 

z <- matrix(y, nrow=3, byrow=T) 
# By changing the "byrow" option, we can fill the matrix by row
z 

## Extracting values from matrices:
z[2,] # Row
z[,3] # Column
z[2,3] # Value

## Other ways to make matrics:
array(data = y, dim = c(3,3))

matrix(c(1,2,3,4,5,6), nrow = 2)

## Create Dataframes:
dat <- as.data.frame(z)
names(dat) <- c("cat", "giraffe","bowlingball")
dat

## R has base functions:
mean(y)
length(y)
sd(y)
var(y)
prod(y) # Takes the product of each element in the vector
apply(z, 2, mean) # Very useful in avoiding for loops, also has useful cousins sapply and lapply

##########################################################
## Introduction to Statistics with R
##########################################################

## Getting help
# help.start()	# Opens html help in web browser (if installed)
# help(help)	# find help on how to use help
# ?help		# Same as above
# help.search("help")	# Find all functions that include the word 'help'

## Getting help on particular functions:
help(plot) # You can use the help function, the argument is an R function
?plot # or just a question mark in front of the funtion you have questions about


## Reading in your data
getwd()		          # What directory are we in?
# R will read and write files to the working directory, unless otherwise specified
setwd("~/Desktop")	# You can change your working directory

## Read in data
dat <- read.table("http://www.stat.yale.edu/~blc3/IntroR2015/remote_weight.txt",
                   header=T, sep="", row.names=NULL, as.is = TRUE)	
# Read data including headers, data separated by spaces, no row names
ls()			          # List all variables stored in memory
head(dat)           # Shows the first 6 rows of the data
head(dat, 10)       # the first 10 rows of the data
tail(dat)           # last 6 rows of the data

## Extracting data from the data frame
dim(dat)	          # Find out how many rows and columns in the data set
names(dat)	        # List all variable names in the dataset 
str(dat)            # Look at the structure of your data
dat		              # See the data frame on the screen
dat[1:10,]	        # See the first 10 rows
dat[,"weight"]	    # See only the weight column
dat[,3]	            # Same as above
dat$weight	        # Yet another way
dat[1:10,"weight"]	# See only the first 10 values of the weight col.
dat[,-1]	          # See all but the first column of data
dat.o <- dat	    # Copy the data frame to a data.frame named dat.0
ls()			          # Now we have 5 variables: 'x', 'y', 'z', 'dat' and 'dat.o'

## Getting familiar with the data
summary(dat)		    # Generate summary statistics of data
apply(dat, 2, sd)	# Calculate standard deviations of all variables
var(dat)		        # Variance on diagonal, covariance off diagonal
mean(dat)		      # Calculate the mean of all variables
pairs(dat)	 	      # A general view of data through scatter plots
pairs(dat[,-1]) 	  
# See scatterplots for all pairs of variables except the first ('id') in the data frame
plot(remote ~ weight, data = dat)	# Scatterplot of 'weight' vs. 'remote'

# Changing data type
class(dat$gender)  # What kind of variable is 'gender'?
dat$gender <- factor(dat$gender)	# Converts 'gender' from type integer to factor 
class(dat$gender)	# Verify that gender is now indeed of type factor
dat$gender			    # See all data in column 'gender'; note "Levels: 0 1" at the bottom

# Attaching the data frame
attach(dat)		    # Attach the data frame
remote			        # Now we can refer directly to the variable without using $

# Basic Graphics
hist(remote)			  # Histogram of 'remote'
hist(weight)			  # Histogram of 'weight'
boxplot(remote,weight)  	  # Boxplot of 'remote' and 'weight' 
boxplot(remote ~ gender)  	# Boxplot of 'remote' conditioned on 'gender'
boxplot(weight ~ gender, main = "Weight by Gender", 
        xlab = "Gender", ylab = "Weight", 
        col = c("forestgreen", "tomato"))	# Boxplot of 'weight' conditioned on 'gender'

## Inferential statistics
cor(remote,weight)		          # Run correlation coefficient
t.test(remote ~ gender)	        # Did frequency of remote use differ by gender?
rem.t <- t.test(remote ~ gender)# Save results of last analysis
rem.t				          # Display analysis
names(rem.t)			    # See the names of variables in the object rem.t
rem.t$statistic		    # See the statistics variable in the object rem.t
mod1 <- lm(remote ~ gender)	    # Linear model, regressing 'remote' on 'gender'
anova(mod1)			      # ANOVA table of the previous model
anova(lm(remote ~ gender))	    # You can combine the two steps in to one line
mod2 <- lm(remote ~ weight)	    # Model 'remote' as a linear function of 'weight'
mod3 <- lm(remote ~ weight + gender)  # Model 'remote' as a linear function of 'weight' & 'gender'
mod4 <- lm(remote ~ weight*gender)  
# Equivalent to all main effects and interaction: 
# lm(remote ~ weight + gender + weight*gender)
summary(mod3)			  # See regression table for model 3 (remote ~ weight + gender)
summary(mod4)			  # See regression table for model 4 (remote ~ weight*gender)
anova(mod3,mod4)		# Prints ANOVA table comparing model 3 to model 4 (delta F)

# Regression diagnostics
mod3.1 <- lm(remote ~ weight + gender)	# Gives you regression diagnostics
par(mfrow=c(2,2))		# Set up plotting region for a 2x2 grid
plot(mod3.1)			  # Plot the regression diagnostics (R knows automatically to do this)

## Saving the graphs as PDF
pdf("prettygraph.pdf")	# Turn on the PDF device and open a blank file called "prettygraph.ps"
plot(mod3.1)			# Plot the model
dev.off()			    # Turn off the postscript device

##########################################################
## Intro to Simulation and Functions with R:
##########################################################

## Create a vector of 12 random numbers drawn
## from a uniform distribution over the 
## interval between 0 and 1:
z <- runif(12) # Generates 12 observations from Unif(0,1)

z

## We can see which of these is less than 0.5 with the expression "z < 0.5"
z < 0.5

## R identifies "True" with "1" and "False" with "0":
as.numeric(z < 0.5)

## Now let x be a vector of 100 random draws from a "Normal" distribution:
x <- rnorm(100) # Generates 100 random normal observations, mean 0 sd 1

x

par(mfrow=c(1,1)) #Resets the graphics to one plot per page
hist(x, main= "100 Obs. Standard Normal Distribution", 
     breaks = 10, col = "gold") # Create a histogram of the vector x

y <- rnorm(100) # save 100 random sample from a standard normal distribution to y

plot(x,y)
plot(x,y,main = "Noise", col = "steelblue", pch = 18)
abline(h=0)
legend("topleft", title = "I'm Normal!", "Obs", pch= 18, 
       col = "steelblue")
plot(x,y,type="l", main = "Nonsense", col = "coral")
#?plot



# Sampling uniformly at random, with replacement
v <- sample(1:10,100,replace=T) # Samples from 1 to 10, 100 times

v

table(v)

## Functions:
## Numerical calculations for birthday problem:
k <- 40

top <- seq(365,length=k,by=-1) # Creates a vector of 365 to 365-k

bottom <- rep(365,k) # Creates a vector filled with 365 repeated k times

top

bottom

top/bottom

prod(top/bottom)  # This is the prob of NO birthday match

1 - prod(top/bottom)  # This is the prob of having a birthday match

## Let's make a function out of what we just did:

bday <- function(k){ # k is the variable
  top <- seq(365,length=k,by=-1)
  bottom <- rep(365,k)
  return(1-prod(top/bottom)) 
} 

bday(40)

##########################################################
## Intro to for loops in R:
##########################################################

s <- 0
for(i in 1:100){
  s <- s+i
}
s

## Sometimes you can do the same thing without a loop:
sum(1:100)

## You can have more commands in the body of the loop:
s <- 0
for(i in 1:10){
  s <- s+i
  cat("When i = ", i, ", s = ",s, "\n",sep="") # "cat" prints things
}

s <- 0
for(i in 1:10){
  s <- s+i
  cat("When i = ", i, ", s = ",s, "\n",sep="")
  remainder2 <- (i %% 2)
  twos <- i/2
  if(remainder2 == 0){
    cat("I'm getting", rep("really", twos),"tired!\n")
  }
}





