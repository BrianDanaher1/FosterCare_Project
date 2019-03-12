# Match a flow
# Pick a column / factor, put it in name, then the program
# filters out the 1st 2nd 3rd 4th 5th cases that link
# to that column / factor

# Written file = "child_flow_custom"

name <- "Placement Setting"
name1 <- paste(c(1, name), collapse = "")
name2 <- paste(c(2, name), collapse = "")
name3 <- paste(c(3, name), collapse = "")
name4 <- paste(c(4, name), collapse = "")
name5 <- paste(c(5, name), collapse = "")

child_flow_custom <- paths[, c("InternalCaseID", "Identification ID", name1, name2, name3, name4, name5) ]

remove(name, name1, name2, name3, name4, name5)
View(child_flow_custom)