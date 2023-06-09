knitr::opts_chunk$set(echo = FALSE)
knitr::opts_knit$set(root.dir = "C:/Users/pauli/OneDrive/Documentos/Classes 2023/311_tech")

library(car)
library(readr)
library(readxl)
library(dplyr)
# reading salary dataset
salary <- read_excel("salary_data_states.xlsx")
#names(salary)
#dim(salary)
colnames(salary)[19] = "Work_State"
colnames(salary)[26] = "Job_Title_Sub"
# filtering
sal <- salary %>%
  filter(!grepl("professor", `Job_Title_Sub`, ignore.case = TRUE) &
           !grepl("attorney", `Job_Title_Sub`, ignore.case = TRUE) &
           !grepl("assistant professor", `Job_Title_Sub`, ignore.case = TRUE) &
           !grepl("teacher", `Job_Title_Sub`, ignore.case = TRUE))
datsal <- sal %>%
  filter(!grepl("Guam", `Work_State`, ignore.case = TRUE) &
           !grepl("Guamam", `Work_State`, ignore.case = TRUE) &
           !grepl("Palau", `Work_State`, ignore.case = TRUE) &
           !grepl("Northern Mariana Islands", `Work_State`, ignore.case = TRUE) &
           !grepl("Puerto Rico", `Work_State`, ignore.case = TRUE) &
           !grepl("Virgin Islands", `Work_State`, ignore.case = TRUE))
# reading CoL dataset
COL <- read_csv("CostOfLiving2023.csv", show_col_types = FALSE)
coldf <- COL[, !(names(COL) %in% c("fips"))]
head(coldf)
# subset
costate <- subset(coldf, select = c(state, costIndex))
# merging
salcost <- merge(datsal, costate,  by.x = "Work_State", by.y = "state")
#head(salcost)

salcost$ADJUSTED_WAGE <- (salcost$PAID_WAGE_PER_YEAR / salcost$costIndex)*100

# new subset
salcost <- salcost[, c("EMPLOYER_NAME", "Job_Title_Sub", "Work_State", "PAID_WAGE_PER_YEAR", "ADJUSTED_WAGE", "costIndex", "WORK_STATE_ABBREVIATION")]


#unique(salcost$Job_Title_Sub)


#  ADJUSTED_WAGE for each state
all_states_med_adjusted <- aggregate(salcost$ADJUSTED_WAGE, by = list(salcost$Work_State), FUN = median)
names(all_states_med_adjusted) <- c("State", "Median_Adjusted_Wage")

# Sort the state_means data frame by Mean_Adjusted_Wage in descending order
all_states_med_adjusted <- all_states_med_adjusted[order(-all_states_med_adjusted$Median_Adjusted_Wage),]


#  PAID_WAGE for each state
all_states_med_paid <- aggregate(salcost$PAID_WAGE_PER_YEAR, by = list(salcost$Work_State), FUN = median)

names(all_states_med_paid) <- c("State", "Median_paid_Wage")

# Sort the state_means data frame by Mean_Adjusted_Wage in descending order
all_states_med_paid <- all_states_med_paid[order(-all_states_med_paid$Median_paid_Wage),]

###################################################

#Looking at the median change  of top 5 states by subtitle after adjusted wage
# First, extract the top 5 states
top_states <- head(all_states_med_paid, 5)$State

# Filter the data by the top 5 states
top_states_data <- salcost[salcost$Work_State %in% top_states, ]

# Calculate the mean ADJUSTED_WAGE by job subtitle and state
state_job_medians <- aggregate(top_states_data$ADJUSTED_WAGE,
                               by = list(top_states_data$Work_State, top_states_data$Job_Title_Sub),
                               FUN = median)

# Rename the columns of the state_job_means data frame
names(state_job_medians) <- c("State", "Job_Title_Sub", "Median_Adjusted_Wage")

# Order the data frame by state and mean adjusted wage in descending order
state_job_medians <- state_job_medians[order(state_job_medians$State, -state_job_medians$Median_Adjusted_Wage),]

# Print the state_job_means data frame
#print(state_job_medians)




###################comparison paid wage##################
########### comparison with payed wage  ################


# Calculate the mean PAID_WAGE_PER_YEAR by job subtitle and state
state_job_med_paidwage <- aggregate(top_states_data$PAID_WAGE_PER_YEAR,
                                    by = list(top_states_data$Work_State, top_states_data$Job_Title_Sub),
                                    FUN = median)

# Rename the columns of the state_job_means data frame
names(state_job_med_paidwage) <- c("State", "Job_Title_Sub", "Med_Paid_Wage")

# Order the data frame by state and mean paid wage in descending order
state_job_med_paidwage <- state_job_med_paidwage[order(state_job_med_paidwage$State, -state_job_med_paidwage$Med_Paid_Wage),]

# Print the state_job_means data frame
print(state_job_med_paidwage)





###############################

# Load ggplot2 library
library(ggplot2)
library(scales)

# Create a new data frame by merging state_job_means and state_job_means_paidwage data frames
state_job_means_all <- merge(state_job_medians, state_job_med_paidwage, by = c("State", "Job_Title_Sub"))



##########We can also look at the bottom states:  


# First, extract the bottom 5 states
bottom_states <- tail(all_states_med_paid, 5)$State

# Filter the data by the bottom 5 states
bottom_states_data <- salcost[salcost$Work_State %in% bottom_states, ]

# Calculate the mean ADJUSTED_WAGE by job subtitle and state
state_job_med_b <- aggregate(bottom_states_data$ADJUSTED_WAGE,
                             by = list(bottom_states_data$Work_State, bottom_states_data$Job_Title_Sub),
                             FUN = median)

# Rename the columns of the state_job_means data frame
names(state_job_med_b) <- c("State", "Job_Title_Sub", "Med_Adjusted_Wage")

# Order the data frame by state and mean adjusted wage in descending order
state_job_med_b <- state_job_med_b[order(state_job_med_b$State, -state_job_med_b$Med_Adjusted_Wage),]

# Print the state_job_means data frame
print(state_job_med_b)


########################

# Calculate the median PAID_WAGE_PER_YEAR by job subtitle and state
state_job_med_paidwage_b <- aggregate(bottom_states_data$PAID_WAGE_PER_YEAR,
                                      by = list(bottom_states_data$Work_State, bottom_states_data$Job_Title_Sub),
                                      FUN = median)

# Rename the columns of the state_job_means data frame
names(state_job_med_paidwage_b) <- c("State", "Job_Title_Sub", "Med_Paid_Wage")

# Order the data frame by state and mean paid wage in descending order
state_job_med_paidwage_b <- state_job_med_paidwage_b[order(state_job_med_paidwage_b$State, -state_job_med_paidwage_b$Med_Paid_Wage),]

# Print the state_job_means data frame
print(state_job_med_paidwage_b)

############################### Here the colors are swaped. we have adjusted to be lighter and paid wage stronger color..

# Load ggplot2 library graph for bottom 5
library(ggplot2)
library(dplyr)

# Create a new data frame by merging state_job_means and state_job_means_paidwage data frames
state_job_means_all_b <- merge(state_job_med_b, state_job_med_paidwage_b, by = c("State", "Job_Title_Sub"))



###################################new
library(ggplot2)
library(dplyr)

# Create the grouped bar plot
p1 <- ggplot(state_job_means_all, aes(x = State, y = Median_Adjusted_Wage, fill = Job_Title_Sub)) +
  geom_bar(position = "dodge", stat = "identity", width = 0.6) +
  geom_bar(aes(y = Med_Paid_Wage), position = "dodge", stat = "identity", width = 0.6, alpha = 0.5) +
  scale_fill_manual(values = c("#F8766D", "#00BA38", "#619CFF", "#FC8D62", "#8B00FF")) +
  labs(x = "State", y = "Med Salary", fill = "Job Title Sub") +
  ggtitle("Median Adjusted (darker) and Median Paid Wages (lighter)") +
  theme(plot.title = element_text(size = 16, hjust = 0.5), axis.text.x = element_text(angle = 45, hjust = 1)) +
  scale_y_continuous(labels = scales::comma, limits = c(0, 150000))

# Create the grouped bar plot
p2 <- ggplot(state_job_means_all_b, aes(x = State, y = Med_Paid_Wage, fill = Job_Title_Sub)) +
  geom_bar(position = "dodge", stat = "identity", width = 0.6) +
  geom_bar(aes(y = Med_Adjusted_Wage), position = "dodge", stat = "identity", width = 0.6, alpha = 0.5) +
  scale_fill_manual(values = c("#F8766D", "#00BA38", "#619CFF", "#FC8D62", "#8B00FF")) +
  labs(x = "State", y = "Med Salary", fill = "Job Title Sub") +
  ggtitle("Median Adjusted (lighter) and Median Paid Wages (darker)") +
  theme(plot.title = element_text(size = 16, hjust = 0.5), axis.text.x = element_text(angle = 45, hjust = 1)) +
  scale_y_continuous(labels = scales::comma, limits = c(0, 150000))

# Display plots side-by-side with shared y-axis limits
library(gridExtra)
grid.arrange(p1, p2, ncol = 2, widths = c(1, 1))


# Calculate the median cost index by state
state_cost_index <- aggregate(salcost$costIndex, by = list(salcost$Work_State), FUN = median)

# Rename the columns of the state_cost_index data frame
names(state_cost_index) <- c("State", "Median_Cost_Index")

# Order the data frame by mean cost index in descending order
state_cost_index <- data.frame(state_cost_index[order(-state_cost_index$Median_Cost_Index), ])

# Print the state_cost_index data frame
#print(state_cost_index)

#head(salcost)

# Calculate the mean paid wage per year by state
state_all_means_paid <- aggregate(PAID_WAGE_PER_YEAR ~ Work_State, data = salcost, FUN = mean)

# Rename the columns of the state_means data frame
names(state_all_means_paid) <- c("State", "Mean_Paid_Wage_Per_Year")

# Order the data frame by mean paid wage per year in descending order
state_all_means_paid <- state_all_means_paid[order(-state_all_means_paid$Mean_Paid_Wage_Per_Year),]

# Print the state_means data frame
#print(state_all_means_paid)
# Print the state medians data frame
#print(all_states_med_paid)


# Calculate the mean adjusted wage by state
state_all_means_adjusted <- aggregate(ADJUSTED_WAGE ~ Work_State, data = salcost, FUN = mean)

# Rename the columns of the state_means_adjusted data frame
names(state_all_means_adjusted) <- c("State", "Mean_Adjusted_Wage")

# Order the data frame by mean paid wage per year in descending order
state_all_means_adjusted <- state_all_means_adjusted[order(-state_all_means_adjusted$Mean_Adjusted_Wage),]

# Print the state_means data frame
#print(state_all_means_adjusted)
# Print the state medians data frame
#print(all_states_med_adjusted)

####################################################################
#Graph of all states means percentage change in wage after adjusted mean wage

# Merge the state_means and state_means_adjusted data frames by state
merged_means <- merge(state_all_means_paid, state_all_means_adjusted, by = "State")


# Add the WORK_STATE_ABBREVIATION column to merged_means
merged_means$WORK_STATE_ABBREVIATION <- salcost$WORK_STATE_ABBREVIATION[match(merged_means$State, salcost$Work_State)]

# Calculate the percentage change of the adjusted wage
merged_means$Percent_Change <- (merged_means$Mean_Adjusted_Wage - merged_means$Mean_Paid_Wage_Per_Year) / merged_means$Mean_Paid_Wage_Per_Year * 100

# Add a column indicating whether the percentage change is positive or negative
merged_means$Positive_Change <- ifelse(merged_means$Percent_Change > 0, "Yes", "No")

# Order the data frame by percent change in descending order
merged_means <- merged_means[order(-merged_means$Percent_Change),]

# Print the merged_means data frame
print(merged_means)


ggplot(data = merged_means, aes(x = WORK_STATE_ABBREVIATION)) +
  geom_bar(aes(y = Percent_Change, fill = Positive_Change), alpha = 0.8, stat = "identity") +
  scale_fill_manual(values = c("red", "green"), guide = "none" ) +
  geom_text(aes(y = Percent_Change, label = paste0(round(Percent_Change, 1), "%")), vjust = -0.5) +
  scale_y_continuous(labels = scales::percent_format()) +
  labs(title = "Mean Adjusted Wage and Percent Change by State",
       x = "State Abbreviation",
       y = "Percent Change",
       color = "Positive Change") +
  theme_minimal()