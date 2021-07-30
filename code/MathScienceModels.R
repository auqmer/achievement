#************************************************************************
# Title: Math and Science Models
# Author: William Murrah
# Description: Linear models predicting 5th grade math and science  
#              achievement
# Created: Friday, 30 July 2021
# R version: R version 4.1.0 (2021-05-18)
# Project(working) directory: /Users/wmm0017/Projects/QMER/achievement
#************************************************************************


eclskmath <- subset(eclsk, select= c("Math_0", "Math_0.5", "Sex", 
                                     "Race", "SES"))
eclskmath <- eclskmath[complete.cases(eclskmath), ]

eclskmath$Race <- relevel(eclskmath$Race, ref = "White")

math0 <- lm(Math_0.5 ~ 1, data = eclskmath)
math1 <- lm(Math_0.5 ~ Math_0, data = eclskmath)
anova(math0, math1)

math2 <- update(math1, . ~ . + Sex + Race + SES)

anova(math1, math2)
summary(math2)

