# loading libraries
library(readxl)

# dataset overview
salary <- read_excel("", col_names = TRUE)
dim(salary)
names(salary)
summary(salary)

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

names(salary)

# strings as factors
caseStat <- as.factor(salary$`Case Status`)
employName <- as.factor(salary$`Employer Name`)
jobTitle <- as.factor(salary$`Job Title`)
jobTitleSub <- as.factor(salary$`Job Title Sub`)
city <- as.factor(salary$`Work City`)

summary(caseStat)
summary(employName)
summary(jobTitle)
summary(jobTitleSub)
summary(city)

# plots for reference
plot(Rnames$call,Rnames$experience)
pie(table(jobTitleSub))
ggplot(Rnames,aes(x=call,fill=ethnicity))+geom_bar(position="fill")
par(mfrow=c(2,2))

# from Ana
# clean the data and keep only data related jobs.

# Define the job titles you want to keep
JOB_TITLE_DATA <- c("software engineer", "business analyst", "management consultant", "data analyst", "data scientist")

# Filter the data to keep only the specified job titles
data <- df[df$JOB_TITLE_SUBGROUP %in% JOB_TITLE_DATA, ]