2*5
4+(8*3)+2
exp(1)
exp(3)
log(4)
sqrt(4)

?log
log(2,4)
log(4,2)
log(x=2, base=4)
log(base=4, x=2)
x<-1
rm(x)

sqrt(exp(4))


mynumber <- 6
mynumber == 5

mynumber == 6

mynumber != 5

mynumber > 7
mynumber < 5

othernumber <- -3

mynumber * othernumber


#object name completion

numSamples <- 50

num_samples <- 40
rm(num_samples)


log("a_word")

log_of_word <- log("a_word")
log_of_word


log_of_negative <- log(-2)

log_of_negative


#challenge

elephant1_kg <- 3492
elephant2_lb < 7757
elephant2_lb <- 7757

elephant1_lb <- elephant1_kg *2.2
elephant2_lb > elephant1_lb


my elephants <- c(elephant1_lb, elephant2_lb)


myelephants <- c(elephant1_lb, elephant2_lb)
which(myelephants == max(myelephants))


weight_g <- (50, 60, 65, 82)

weight_g <- c(50, 60, 65, 82)

animals <- c("mouse", "rat", "dog")

length(weight_g)

length(animals)

class(weight_g)

class(animals)

str(weight_g)

str(animals)

weight_g <- c(weight_g, 90)

weight_g <- c(30, weight_g)

str(weight_g)

num_char <- c(1, 2, 3, "a")

num_logical <- c(1, 2, 3, TRUE)

char_logical <- c("a", "b", "c", TRUE)

tricky <- c(1, 2, 3, "4")

animals{2}

animals <- {2}
 
animals <- c("mouse", "rat", "dog", "cat")

animals{2}

animals[2]

class(weight_g)

class(num_char)


getwd()


#project management


getwd()

# Relative file path

  
#Raw data considered read only file
  
  
  
#How R thinks about data ----

## Vector and data Types ----

### Create Objects ----

####Use c to concatenate ie add multiple objects

weight <- c(50, 73, 47, 2)

weight
### vector with text

#surround the words with quotes - for character values
animals <- c("mouse", horse, "rat")

animals <- c("mouse", "horse", "rat")

#explore the objects
#class of vector

#additional functions
#class

class(weight)

class(animals)
#length

lenght(weight)

length(weight)
length(animals)

#structure
str(weight)

str(animals)

#change vector


weight <- c(weight, 90) #adds to the end of the vector
weight
weight

weight <- c(3, weight)

weight


#Subsetting

##Extracting specific values out of vectors

animals <- c("mouse", "rat", "dog", "cat")

#use square brackets
animals[2]

#use concatenate function (c) to extract multiple values
animals[c(2,3)]

#create a new set of values 
animals[c(2,3,2,3,2,3)]


#conditional subsetting 
##using logical vector subsetting

weight <- c(14, 76, 81, 21, 46)

weight[c(TRUE, TRUE, FALSE, FALSE, FALSE)]
##specify the condition
weight[weight > 50]
weight > 50

#multiple tests
weight[weight > 50 | weight < 20]

#or is denoted by the straight line as above

# AND ---> & 
# other symbols

weight[weight >= 30]
weight[weight >=46]

weight[weight >= 46]








