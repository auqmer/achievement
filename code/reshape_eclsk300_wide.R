#************************************************************************
# Title: reshape eclska300  to wide
# Author: William Murrah
# Description: description
# Created: Friday, 30 July 2021
# R version: R version 4.1.0 (2021-05-18)
# Project(working) directory: /Users/wmm0017/Projects/QMER/achievement
#************************************************************************
library(reshape2)
load("data/eclska300.Rdata")
#eclska300 <- read.csv("data/eclska300.csv", header = TRUE)
# Replace any blank spaces in variable names with underscore to help with 
# parsing in the reshape functions.
names(eclska300) <- gsub(" ", "_", names(eclska300))

# Time invariant variables and the timing variable:
idvars <- c("id", "time2", "Sex", "Race", "SES",
            "PreK", "District_Poverty")

# Time varying variables (excluding the timing variable)
mvars <- c("Math", "Reading", "Science", "DCCS", 
           "Numbers_Reversed", 
           "Numbers_Reversed_(W-ability)")  

# melt and dcast in one step:
eclskwide <- recast(data = eclska300, 
                    formula = id + Sex + Race + SES + PreK +
                      District_Poverty ~ variable + time2,
                    id.var = idvars, measure.var = mvars)

# Science at time 0 is missing (was not measured), so remove
eclskwide$Science_0 <- NULL
eclskwide$Race <- relevel(eclskwide$Race, ref = "White")
rm(idvars, mvars)

save(eclskwide, file = "data/eclskwide.Rdata")
write.csv(eclskwide, file = "data/eclskwide.csv", row.names = FALSE)

rm(eclska300)

