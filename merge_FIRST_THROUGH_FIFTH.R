# Connect all cases together and label by 1st, 2nd, 3rd
# Written & exported data file is wide

first_case <- first_removals
second_case <- second_removals
third_case <- third_removals
fourth_case <- fourth_removals
fifth_case <- fifth_removals

all_cases <- merge(first_case, second_case, by='Identification ID', all=TRUE)
all_cases <- merge(all_cases, third_case, by='Identification ID', all=TRUE)
fourfive <- merge(fourth_case, fifth_case, by='Identification ID', all=TRUE)
all_cases <- merge(all_cases, fourfive, by='Identification ID', all=TRUE)

paths <- all_cases[,-c(11,20,29,38)]
#remove(all_cases)
names(paths) <- c("Identification ID", "InternalCaseID", "1Removal Date", "1Placement Begin Date", "1Placement End Date", "1Service", "1Episode Type", "1Placement Setting", "1Ending Purpose", "1End Reason", "2Removal Date", "2Placement Begin Date", "2Placement End Date", "2Service", "2Episode Type", "2Placement Setting", "2Ending Purpose", "2End Reason", "3Removal Date", "3Placement Begin Date", "3Placement End Date", "3Service", "3Episode Type", "3Placement Setting", "3Ending Purpose", "3End Reason", "4Removal Date", "4Placement Begin Date", "4Placement End Date", "4Service", "4Episode Type", "4Placement Setting", "4Ending Purpose", "4End Reason", "5Removal Date", "5Placement Begin Date", "5Placement End Date", "5Service", "5Episode Type", "5Placement Setting", "5Ending Purpose", "5End Reason")

write.csv(paths, "child_paths.csv")

#child_flow_services <- paths[, c("InternalCaseID", "Identification ID", "1Service", "2Service", "3Service")]
#child_flow_endreasons <- paths[, c("InternalCaseID", "Identification ID", "1End Reason", "2End Reason", "3End Reason")]
#child_flow_datescheck <- paths[ , c("InternalCaseID", "Identification ID", "1Placement Begin Date", "2Placement Begin Date", "3Placement Begin Date")]

remove(first_case, second_case, third_case, fourth_case, fifth_case)