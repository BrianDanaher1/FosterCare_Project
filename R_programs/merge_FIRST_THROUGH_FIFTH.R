# Connect all cases together and label by 1st, 2nd, 3rd, 4th, 5th
# Needs updating, especially with standard for names in paths df

# USE match_flow.R for utilization of the "paths" df

# Written & exported data file ("paths", "paths.csv") is WIDE - this is GOOD, USED TO TRACK placements over time

all_cases <- merge(first_removals, second_removals, by='Identification ID', all=TRUE)
all_cases <- merge(all_cases, third_removals, by='Identification ID', all=TRUE)

# Addition of 4th and 5th cases
fourfive <- merge(fourth_removals, fifth_removals, by='Identification ID', all=TRUE)
all_cases <- merge(all_cases, fourfive, by='Identification ID', all=TRUE)

paths <- all_cases[,-c(11,20,29,38)]  # Remove repeating case ID
names(paths) <- c("Identification ID", "InternalCaseID", "1Removal Date", "1Placement Begin Date", 
                  "1Placement End Date", "1Service", "1Episode Type", "1Placement Setting", "1Ending Purpose", 
                  "1End Reason", "2Removal Date", "2Placement Begin Date", "2Placement End Date", "2Service", 
                  "2Episode Type", "2Placement Setting", "2Ending Purpose", "2End Reason", "3Removal Date", 
                  "3Placement Begin Date", "3Placement End Date", "3Service", "3Episode Type", "3Placement Setting", 
                  "3Ending Purpose", "3End Reason", "4Removal Date", "4Placement Begin Date", "4Placement End Date", 
                  "4Service", "4Episode Type", "4Placement Setting", "4Ending Purpose", "4End Reason", "5Removal Date", 
                  "5Placement Begin Date", "5Placement End Date", "5Service", "5Episode Type", "5Placement Setting", 
                  "5Ending Purpose", "5End Reason")

# Write WIDE file
write.csv(paths, "child_paths.csv")

# Some testing subsets below

# child_flow_services <- paths[, c("InternalCaseID", "Identification ID", "1Service", "2Service", "3Service")]
# child_flow_endreasons <- paths[, c("InternalCaseID", "Identification ID", "1End Reason", "2End Reason", "3End Reason")]
# child_flow_datescheck <- paths[ , c("InternalCaseID", "Identification ID", "1Placement Begin Date", "2Placement Begin Date", "3Placement Begin Date")]

remove(all_cases, fourfive)