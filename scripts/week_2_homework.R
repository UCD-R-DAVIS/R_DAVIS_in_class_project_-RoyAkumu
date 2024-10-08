set.seed(15)
hw2 <- runif(50, 4, 50)
hw2 <- replace(hw2, c(4,12,22,27), NA)
hw2

#removing all NAs
na.omit(hw2)

hw2
prob1 <- na.omit(hw2)

prob1

is.na(hw2)

is.na(prob1)

hw2_without_na <- hw2[!is.na(hw2)]

hw2_without_na

#selecting numbers in vector between 14th and 38th place (14 and 13 inclusive)

hw2_without_na [hw2_without_na >=14 & hw2_without_na<= 38]


prob1_b <- hw2_without_na [hw2_without_na >=14 & hw2_without_na<= 38]

prob1_b

#adding 3 to prob1_b

times3 <- prob1_b*3

times3

#multiplying times3 by 10

plus10<- times3+10

plus10

#selecting every other number ie 1, 3, 5 etc

select_odd <- plus10[seq(from = 1, to = length(plus10), by = 2)]

select_odd
