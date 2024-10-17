# Load "survey" data frame 
surveys <- read.csv("data/portal_data_joined.csv")
surveys

str(surveys)

# new data frame with only species_id, weight, plot_type

surveys_base <- surveys[,c("species_id", "weight", "plot_type")]

surveys_base
str(surveys_base)

#selecting only first 5000 rows

Rows5k <- surveys_base[1:5000, ]

Rows5k
str(Rows5k)

# converting species_id and plot_type to factors

Rows5k$species_id <- factor(Rows5k$species_id)
str(Rows5k)

Rows5k$plot_type <- factor(Rows5k$plot_type)
str(Rows5k)

# removing all rows with NA in the weight column
##checking where the NAs occur
colSums(is.na(Rows5k))


Rows5k_without_nas <- na.omit(Rows5k, col="weight")

Rows5k_without_nas

colSums(is.na(Rows5k_without_nas))

# challenge to select only values with weight > 150 from survey_base

challenge_base <- surveys_base[surveys_base[,2] > 150, ]
challenge_base
