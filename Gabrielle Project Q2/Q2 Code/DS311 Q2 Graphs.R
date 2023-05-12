# loading libraries
library(readxl)
library(caret)
library(ggplot2)
library(dplyr)

# dataset overview
salary <- read_excel("C:/Users/knigh/OneDrive/Desktop/Github/We-R-Finished/salary/salary_data_states.xlsx")

# renaming columns
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

# filtering job sub types
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

# variables
stateAbb <- ssal$`WS Abb`
jobSub <- ssal$`Job Title Sub`
paidWage <- ssal$`Paid Wage/Yr`
ssal$Sub <- factor(ssal$`Job Title Sub`, levels = c("business analyst", "data analyst", "data scientist", "management consultant", "software engineer"))

# job sub/state plot
ggplot(ssal, aes(x = stateAbb, fill = jobSub)) + 
  geom_bar() + 
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1)) +
  labs(x = "Work State Abbreviation", y = "Count", title = "Job Subcategories in Each State")

# state/job sub
ggplot(ssal, aes(x = jobSub, fill = stateAbb)) + 
  geom_bar() + 
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1)) +
  labs(x = "Job Title Sub", y = "Count", title = "States for Each Job Subcategory")

# paid wage boxplot
ggplot(ssal, aes(x = jobSub, y = paidWage, fill = jobSub)) +
  geom_boxplot() +
  labs(title = "Paid Wage/Year by Job Sub-Type",
       x = "Job Sub-Type",
       y = "Paid Wage/Year",
       fill = "Job Sub-Type")

# no outliers
ggplot(ssal, aes(x = jobSub, y = paidWage, fill = jobSub)) +
  geom_boxplot() +
  labs(title = "Paid Wage/Year by Job Sub-Type",
       x = "Job Sub-Type",
       y = "Paid Wage/Year",
       fill = "Job Sub-Type") +
  scale_y_continuous(limits = quantile(paidWage, c(0.1, 0.9)))

# Job subtype/ State
# Texas
ssal %>%
  filter(`Work State` == "Texas", `Paid Wage/Yr` > quantile(`Paid Wage/Yr`, 0.05) & `Paid Wage/Yr` < quantile(`Paid Wage/Yr`, 0.95)) %>%
  ggplot(aes(x = Sub, y = `Paid Wage/Yr`)) +
  geom_boxplot(fill = "darkorange1", color = "darkorange4") +
  labs(x = "Job Sub-Type", y = "Paid Wage/Year", title = "Salary Distribution in Texas")

# New York
ssal %>%
  filter(`Work State` == "New York", `Paid Wage/Yr` > quantile(`Paid Wage/Yr`, 0.05) & `Paid Wage/Yr` < quantile(`Paid Wage/Yr`, 0.95)) %>%
  ggplot(aes(x = Sub, y = `Paid Wage/Yr`)) +
  geom_boxplot(fill = "lightblue", color = "skyblue4") +
  labs(x = "Job Sub-Type", y = "Paid Wage/Year", title = "Salary Distribution in New York")

# New Jersey
ssal %>%
  filter(`Work State` == "New Jersey", `Paid Wage/Yr` > quantile(`Paid Wage/Yr`, 0.05) & `Paid Wage/Yr` < quantile(`Paid Wage/Yr`, 0.95)) %>%
  ggplot(aes(x = Sub, y = `Paid Wage/Yr`)) +
  geom_boxplot(fill = "moccasin", color = "khaki3") +
  labs(x = "Job Sub-Type", y = "Paid Wage/Year", title = "Salary Distribution in New Jersey")

# Illinois
ssal %>%
  filter(`Work State` == "Illinois", `Paid Wage/Yr` > quantile(`Paid Wage/Yr`, 0.05) & `Paid Wage/Yr` < quantile(`Paid Wage/Yr`, 0.95)) %>%
  ggplot(aes(x = Sub, y = `Paid Wage/Yr`)) +
  geom_boxplot(fill = "darkorange1", color = "navyblue") +
  labs(x = "Job Sub-Type", y = "Paid Wage/Year", title = "Salary Distribution in Illinois")

# Massachussetts
ssal %>%
  filter(`Work State` == "Massachusetts", `Paid Wage/Yr` > quantile(`Paid Wage/Yr`, 0.05) & `Paid Wage/Yr` < quantile(`Paid Wage/Yr`, 0.95)) %>%
  ggplot(aes(x = Sub, y = `Paid Wage/Yr`)) +
  geom_boxplot(fill = "goldenrod2", color = "darkslateblue") +
  labs(x = "Job Sub-Type", y = "Paid Wage/Year", title = "Salary Distribution in Massachusetts")

# Virginia
ssal %>%
  filter(`Work State` == "Virginia", `Paid Wage/Yr` > quantile(`Paid Wage/Yr`, 0.05) & `Paid Wage/Yr` < quantile(`Paid Wage/Yr`, 0.95)) %>%
  ggplot(aes(x = Sub, y = `Paid Wage/Yr`)) +
  geom_boxplot(fill = "seashell", color = "dodgerblue4") +
  labs(x = "Job Sub-Type", y = "Paid Wage/Year", title = "Salary Distribution in Virginia")

# Pennsylvania
ssal %>%
  filter(`Work State` == "Pennsylvania", `Paid Wage/Yr` > quantile(`Paid Wage/Yr`, 0.05) & `Paid Wage/Yr` < quantile(`Paid Wage/Yr`, 0.95)) %>%
  ggplot(aes(x = Sub, y = `Paid Wage/Yr`)) +
  geom_boxplot(fill = "gold2", color = "royalblue4") +
  labs(x = "Job Sub-Type", y = "Paid Wage/Year", title = "Salary Distribution in Pennsylvania")

# Washington
ssal %>%
  filter(`Work State` == "Washington", `Paid Wage/Yr` > quantile(`Paid Wage/Yr`, 0.05) & `Paid Wage/Yr` < quantile(`Paid Wage/Yr`, 0.95)) %>%
  ggplot(aes(x = Sub, y = `Paid Wage/Yr`)) +
  geom_boxplot(fill = "springgreen4", color = "gold3") +
  labs(x = "Job Sub-Type", y = "Paid Wage/Year", title = "Salary Distribution Washington")

# Michigan
ssal %>%
  filter(`Work State` == "Michigan", `Paid Wage/Yr` > quantile(`Paid Wage/Yr`, 0.05) & `Paid Wage/Yr` < quantile(`Paid Wage/Yr`, 0.95)) %>%
  ggplot(aes(x = Sub, y = `Paid Wage/Yr`)) +
  geom_boxplot(fill = "darkslateblue", color = "goldenrod3") +
  labs(x = "Job Sub-Type", y = "Paid Wage/Year", title = "Salary Distribution Michigan")

# North Carolina
ssal %>%
  filter(`Work State` == "North Carolina", `Paid Wage/Yr` > quantile(`Paid Wage/Yr`, 0.05) & `Paid Wage/Yr` < quantile(`Paid Wage/Yr`, 0.95)) %>%
  ggplot(aes(x = Sub, y = `Paid Wage/Yr`)) +
  geom_boxplot(fill = "skyblue", color = "steelblue") +
  labs(x = "Job Sub-Type", y = "Paid Wage/Year", title = "Salary Distribution in North Carolina")

