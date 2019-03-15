# FEATURE ENGINEERING
# Extrapolate more columns of information,
# fill up all_numbers df with new data,
# for use with machine learning models

# Load up dplyr for manipulation and filtering
library(dplyr)

# Choose the cases that we need, those that are actually in same data set
cases_relevant <- filter(cases, cases$`InternalCaseID` %in% case_rem_place$`InternalCaseID`)

# Put caseID into all_numbers
i <- 1
for (ID in all_numbers$`Identification ID`)
  {
  spot <- which(case_rem_place$`Identification ID` == ID)
  
  all_numbers[i,1] <- case_rem_place[spot[1], 1]
  
  i = i+1
  }

# Put zip code into all_numbers (remember, some do not have zips)
i <- 1
for (caseID in all_numbers$`InternalCaseID`)
  {
  spot <- which(cases_relevant$`InternalCaseID` == caseID)
  all_numbers[i,4] <- as.double(cases_relevant[spot[1], 5])
  
  i = i+1
  }

# Remove data that did not include zip code information
all_numbers <- filter(all_numbers, !is.na(all_numbers$Zip))


# Is the zip code in top 7 "problematic" area or not?
# Remember TRUE = 1 = in, FALSE = 0 = out
i <- 1

# Which zips are problematic?
zips <- c(32331, 32359, 32060, 32680, 32626, 32348, 32055)

for (zipcode in all_numbers$`Zip`)
  {
  spot <- which(cases_relevant$`zip5` == zipcode)
  
  if (zipcode %in% zips) 
    {
    all_numbers[i,5] <- 1
    }

  else 
    {
    all_numbers[i,5] <- 0
    }
  
  i = i+1
  
  }


# Find number of participants per child's case
i <- 1
uniqueIDs <- unique(all_numbers$`Identification ID`)  # Unique IDs in data

for (ID in uniqueIDs) 
  {
  spot <- which(all_numbers$`Identification ID` == ID)
  caseID <- as.double(all_numbers[spot[1], 1])
  
  one_case <- filter(ALL_PARTICIPANTS, ALL_PARTICIPANTS$`PseudoCaseID` == caseID)
  number_of_participants <- length(unique(one_case$`Identification ID`))
  
  for (place in spot) 
    {
    all_numbers[place,7] <- number_of_participants
    }
  
  i = i+1
  
  }


# Add Zip Count (number of cases in Zip) to all_numbers
i <- 1

for (zip in all_numbers$Zip) 
  {
  all_numbers[i,9] <- nrow(filter(cases, cases$zip5 == zip))
  i = i+1
  }

# Convert these character strings into doubles before moving on
# This is important for machine learning programs
all_numbers$ZipCount <- as.double(all_numbers$ZipCount)


# Add Zip Density (Zip Count / Pop Density of Zip) to all_numbers
i <- 1
for (zip in all_numbers$Zip) 
  {
  spot <- which(PopDensity$`Zip/ZCTA` == zip)
  all_numbers[i,10] <- (all_numbers[i,9] / PopDensity[spot[1], 4])
  
  i = i+1
  }

# ZipDens is a number --> make it a double
all_numbers$ZipDens <- as.double(all_numbers$ZipDens)

# Remove data that does not have ZipDens (missing Zip or density in calculation)
all_numbers <- filter(all_numbers, !is.na(all_numbers$ZipDens))

# Case Duration --> in days, (end date - start date)
i <- 1
for (caseID in all_numbers$`InternalCaseID`)
  {
  spot <- which(cases$`InternalCaseID` == caseID)
  all_numbers[i,11] <- (cases[spot[1], 4] - cases[spot[1], 3])
  
  i = i+1
  }

# Filter out those with missing case dates (calculation will be 0)
all_numbers <- filter(all_numbers, !is.na(all_numbers$CaseDuration))

# Calcualte age of child

# Copy ALL_PARTICIPANTS df
copy <- filter(ALL_PARTICIPANTS, ALL_PARTICIPANTS$MonthOfBirth != "/")

# Common errors in df for months and dates - just change to Jan 1st
copy$Year <- gsub("^", "01/01/", copy$Year)
copy$Year <- as.Date.character(copy$Year, format="%d/%m/%Y")

# Gsub dates that were just a "/", another common error in data entry
copy$MonthOfBirth <- gsub("/", "/01/", copy$MonthOfBirth)

# Format month of birth to a full date so we can subtract for age
copy$MonthOfBirth <- as.Date.character(copy$MonthOfBirth, format="%d/%m/%Y")

# Now add to all_numbers df
i <- 1
for (ID in all_numbers$`Identification ID`)
  {
  spot <- which(copy$`Identification ID` == ID)
  all_numbers[i,12] <- (copy[spot[1], 36] - copy[spot[1], 6])
  
  i = i+1
  }

# Convert age in days to age in years
all_numbers$Age <- all_numbers$Age / 365


# Calculate number of caregivers in case and the average age of them
# Set to 1 to fill columns, then rewrite
all_numbers <- mutate(all_numbers, "NumCaregivers" = 1)
all_numbers <- mutate(all_numbers, "CareAge" = 1)

i <- 1
uniqueIDs <- unique(all_numbers$`Identification ID`)  # Current unique IDs in df

for (ID in uniqueIDs) 
  {
  spot <- which(all_numbers$`Identification ID` == ID)
  caseID <- as.double(all_numbers[spot[1], 1])
  
  one_case <- filter(copy, copy$`PseudoCaseID` == caseID)
  
  # DF with just caregivers' records
  caregivers <- filter(one_case, one_case$`Service Role` == "Primary Caregiver" | one_case$`Service Role` == "Secondary Caregiver")
  
  # Length of this ^ DF is how many caregivers present
  number_of_caregivers <- length(unique(caregivers$`Identification ID`))
  
  # Find ages of each caregiver, sum them / number_of_caregivers = average age of caregiver in case
  # Add this number to the same record in additional column in all_numbers
  average <- mean(caregivers$`Year` - caregivers$`MonthOfBirth`)
  
  for (careID in caregivers$`Identification ID`)
    {
    all_numbers[i,14] <- average / 365
    }
  
  
  for (careID in caregivers$`Identification ID`) 
    {
    all_numbers[i,13] <- number_of_caregivers
    }
  
  i = i+1
  
  }

# Remove data where there were no caregivers
all_numbers <- filter(all_numbers, all_numbers$NumCaregivers != 0)

# Remove data where caregiver age absent
all_numbers <- filter(all_numbers, !is.na(all_numbers$CareAge))

# Clean up R Studio
remove(uniqueIDs, zips, zipcode, spot, i, ID, caseID, number_of_participants, one_case, place, zip, caregivers, number_of_caregivers)

# Write created df with extrapolated / calculated values as a .csv
write.csv(all_numbers, "all_numbers.csv")
