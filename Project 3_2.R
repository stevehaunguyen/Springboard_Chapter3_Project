library(dplyr)
library(tidyr)

#0. Load the data in RStudio --------------------------------------------
titanic <- read.csv(file = "titanic_original.csv")

#1. Put "S" for missing values in embarked column -----------------------
unique(titanic$embarked)

titanic$embarked <- ifelse(titanic$embarked == "S", "S",
                           ifelse (titanic$embarked == "C", "C",
                                   ifelse(titanic$embarked == "Q", "Q", "S")))

#2. Age -----------------------------------------------------------------
unique(titanic$age)

mean_age <- mean(titanic$age, na.rm = TRUE)

titanic$age <- ifelse(is.na(titanic$age), mean_age, titanic$age)

#Other ways to populate missing values in age column: Could use median, mode

#Would pick using median over the mean, because the age range could be heavily skewed to one side or the other
# while the median would encompass the range nicely

#Would not pick mode because the mode probably will not be a good representation for statistical purposes


#3. Fill empty slots with a dummy value in the lifeboat column ----------

unique(titanic$boat)

titanic$boat <- ifelse(grepl(pattern = ".+", titanic$boat), sapply(titanic$boat, toString), NA)


#4. Create a new column "has_cabin_number" ------------------------------
titanic$has_cabin_number <- ifelse(grepl(pattern = ".+", titanic$cabin), 1, 0)


write.csv(titanic, "titanic_clean.csv")
