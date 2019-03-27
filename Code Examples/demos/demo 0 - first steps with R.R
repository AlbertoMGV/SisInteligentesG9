#---------------------------------------------------------------------------
# First steps with R
# Intelligent Systems - University of Deusto
# Enrique Onieva Caracuel
#---------------------------------------------------------------------------
# This script aims to present the general sintax of R. As wells as a set
# of commom operations needed during the rest of the Subject
#---------------------------------------------------------------------------


# R is a scripting language where we can execute the line-by-line code
# To go through the code, just get on the line (or mark the piece)
# of code to execute and press Control + Enter
# (We can also use the button above the editor << Run >>)
#---------------------------------------------------------------------------
## Preparing the work environment

# With the following two commands we clean the work environment and the console
rm(list = ls())
cat("\014")
graphics.off()

# Another point is to establish the working directory, with this command we make
# this is equal to the one where the script is located
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
# This command can give an error if there are accents or other "strange" characters in
# the route. If so, you can directly write the path between quotes and
# careful with the direction of the bars
# setwd ("c:/Users/Adm...")
# Or you can use the menu option "Sessions-> Set Working Directory-> To Source File Location"
# In addition, you could need to install the rstudioapi package...
#       - (Left bottom panel) -> "Packages" tab -> "Install" button -> (write package name)
#       - You will need to install several packages during the course

# We check that it is correct
getwd()
dir()
#---------------------------------------------------------------------------

# In R, there is no need to allocate memory for variables, or "worry" about their types
# Both "<-" and "=" are assignment operators. 
# If you look at code online, you can find the assignment like this: "a <- 2" (it's similar)
a = 2
b = "two"
a = "Three"
b = 3.4
# You cand see declared variables in the upper right pannel called "Environment".


# To declare vectors, just assign them, and just call a variable to show its
# content by the console
vec = c(1,2,3,4,5,6)
vec

vec = c(TRUE, TRUE, FALSE, TRUE)
vec = c("one","two","three")

# There are many commands to create and initialize vectors (and matrices)
vec_1 = 1:10               # Numbers from 1 to 10
vec_2 = seq(1, 10, 2)      # Sequence from 1 to 10 adding 2 in each step 
vec_3 = runif(10, 50, 100) # Generate 10 random decimal numbers between 50 and 100
vec_4 = rep(c(1, 2), 10)   # Repeat 10 times the content of a vector
vec_5 = sample(1:10)       # Generate a vector with numbes between 1 and 10 in a random order

mat = matrix(0,nrow=5,ncol=3)
mat

# We access vectors and matrices with brackets
vec[2]
mat[1,3]

# For matrices, we can access an entire row / column
mat[1,]
mat[,1]

# And to do operations over multiple elements
mat[1,] = 10 # Set to 10 all the elements of row 1.
mat

mat[,2] = mat[,2]+10 # Add 10 to all the elements of column 2.
mat

# Square all the elements of vec_2 
vec_2 = vec_2^2
vec_2

# FOR structures can be used 
# (although they are not recommended, because they are inefficient)
for (i in 1:nrow(mat)) {
  mat[i,3] = mat[i,3]+1 # Add 1 to all the elements of column 3.
}

mat

# Another efficient (and necessaryin some cases) option is to use functions of the family apply
apply(mat, 1, mean) # Calculate the mean of all rows. '1' define the rows of a matrix.
apply(mat, 2, mean) # Calculate the mean of all columns. '2' define the columns of a matrix.

# Definition of a function
TestFunction = function(x) {
  value = x[2]^2-x[3]
  return(value)
}

TestFunction(c(1,3,5))
mat[,1] = apply(mat,1,function(x) TestFunction(x))
mat

# Making validations or conditional changes on a vector (or matrix)
vec = sample(1:10) # Create a vector of numbers between 1 and 10 and order randomly.
vec
vec < 5            # Check if all the elements are lower than 5.
which(vec < 5)     # Get the indexes with value lower than 5.
vec[vec < 5] = 0   # Set to 0 elements lower than 5.
vec

mat
which(mat == 1)
# Get the index of all the elements with value 1. Retuns the correlative index starting at position 1, 1
# (next positions: [1,2], [1,3]....).
which(mat == 1, arr.ind = TRUE) # Get the row,col of all the elements with value 1
mat[mat == 1] = 0 # Set to 0 all the element with value 1
mat

# Lists (usefull in this subject)
item1 = list()         # Create an (empty) list
item1$name = "Mike"    # include a "name" variable, which contains string
item1$age = 29         # include a "name" variable, which contains a number
item1$cities = c("Donosti", "Bilbao") # include a "name" variable, which contains a vector
item1$mat = matrix(0,nrow=3,ncol=3)   # include a "name" variable, which contains a matrix

# Creation of another element
item2 = list()
item2$name = "Mary"
item2$age = 30
item2$cities = c("Donosti", "Bilbao", "Madrid")
item2$mat = matrix(0,nrow=3,ncol=3)

# Accessing to elements in lists
item2$name # value of "name" on item2
item2[[1]] # 1st element of item2
item2[[3]][2] # 2nd element of the 3rd element on item2

# Lists of lists (in this case, list of persons)
persons = list(item1, item2) 
persons[[1]]$cities[1] # 1st city of the 1st person of the list