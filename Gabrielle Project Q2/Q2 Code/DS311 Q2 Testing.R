# loading libraries
library(readxl)
library(caret)
library(ggplot2)
library(dplyr)

# dataset overview
salary <- read_excel("C:/Users/knigh/OneDrive/Desktop/Github/We-R-Finished/salary/salary_data_states.xlsx")

# renaming
colnames(salary)[1] = "Case Number"
colnames(salary)[2] = "Case Status"
colnames(salary)[3] = "Received Date"
colnames(salary)[4] = "Decision Date"
colnames(salary)[5] = "Employer Name"
colnames(salary)[6] = "Submitted Prevail Wage"
colnames(salary)[7] = "SPrW Unit"
colnames(salary)[8] = "Submitted Paid Wage"
colnames(salary)[9] = "SPaW Unit"
colnames(salary)[10] = "Job Title"
colnames(salary)[11] = "Work City"
colnames(salary)[12] = "Required Edu"
colnames(salary)[13] = "Required College Major"
colnames(salary)[14] = "Exp Req"
colnames(salary)[15] = "Exp Req (Months)"
colnames(salary)[16] = "Citizenship"
colnames(salary)[17] = "Prevail Wage SOC Code"
colnames(salary)[18] = "PWSOC Title"
colnames(salary)[19] = "Work State"
colnames(salary)[20] = "WS Abb"
colnames(salary)[21] = "WPostal Code"
colnames(salary)[22] = "Full Time"
colnames(salary)[23] = "Visa Class"
colnames(salary)[24] = "Prevail Wage/Yr"
colnames(salary)[25] = "Paid Wage/Yr"
colnames(salary)[26] = "Job Title Sub"
colnames(salary)[27] = "Order"

# filter
sal <- salary %>%
  filter(!grepl("professor", `Job Title Sub`, ignore.case = TRUE) & 
           !grepl("attorney", `Job Title Sub`, ignore.case = TRUE) &
           !grepl("assistant professor", `Job Title Sub`, ignore.case = TRUE) & 
           !grepl("teacher", `Job Title Sub`, ignore.case = TRUE))
jobTitleSub <- as.factor(sal$`Job Title Sub`)
summary(jobTitleSub)

# filtering states
datsal <- sal %>%
  filter(!grepl("Guam", `Work State`, ignore.case = TRUE) & 
           !grepl("Guamam", `Work State`, ignore.case = TRUE) &
           !grepl("Palau", `Work State`, ignore.case = TRUE) & 
           !grepl("Northern Mariana Islands", `Work State`, ignore.case = TRUE) &
           !grepl("Puerto Rico", `Work State`, ignore.case = TRUE) &
           !grepl("Virgin Islands", `Work State`, ignore.case = TRUE))

topState <- c("Texas", "New York",
              "New Jersey", "Illinois", "Massachusetts",
              "Virginia", "Pennsylvania", "Washington",
              "Michigan", "North Carolina")
ssal <- datsal[datsal$`Work State` %in% topState, ]

# added new col
ssal$Sub <- factor(ssal$`Job Title Sub`, levels = c("business analyst", "data analyst", "data scientist", "management consultant", "software engineer"))

ssal %>%
  filter(`Work State` == "Massachusetts") %>%
  nrow()

# Massachussetts
ssal %>%
  filter(`Work State` == "Massachusetts") %>%
  ggplot(aes(x = Sub, y = `Paid Wage/Yr`)) +
  geom_boxplot(fill = "goldenrod2", color = "darkslateblue") +
  labs(x = "Job Sub-Type", y = "Paid Wage/Year", title = "Salary Distribution in Massachussetts")

# North Carolina
ssal %>%
  filter(`Work State` == "North Carolina") %>%
  ggplot(aes(x = Sub, y = `Paid Wage/Yr`)) +
  geom_boxplot(fill = "skyblue", color = "steelblue") +
  labs(x = "Job Sub-Type", y = "Paid Wage/Year", title = "Salary Distribution in North Carolina")

