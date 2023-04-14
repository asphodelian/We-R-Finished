library(readr)
library(dplyr)

# dataset
COL2023 <- read_csv("C:/Users/knigh/OneDrive/Desktop/Github/We-R-Finished/CostOfLiving2023.csv", show_col_types = FALSE)
coldf <- COL2023[, !(names(COL2023) %in% c("fips"))]

# variables
state <- coldf$state
density <- coldf$densityMi
pop2023 <- coldf$pop2023
pop2022 <- coldf$pop2022
pop2020 <- coldf$pop2019
pop2019 <- coldf$pop2019
pop2010 <- coldf$pop2010
growthRate <- coldf$growthRate
growth <- coldf$growth
growth2010 <- coldf$growthSince2010
costIndex <- coldf$costIndex
grocery <- coldf$groceryCost
housing <- coldf$housingCost
utility <- coldf$utilitiesCost
transport <- coldf$transportationCost
misc <- coldf$miscCost

# top10 states
TX <- coldf[state == "Texas", ]
NY <- coldf[state == "New York", ]
NJ <- coldf[state == "New Jersey", ]
IL <- coldf[state == "Illinois", ]
MA <- coldf[state == "Massachusetts", ]
VA <- coldf[state == "Virginia", ]
PA <- coldf[state == "Pennsylvania", ]
WA <- coldf[state == "Washington", ]
MI <- coldf[state == "Michigan", ]
NC <- coldf[state == "North Carolina", ]
state <- c(TX, NY, NJ, IL, MA, VA, PA, WA, MI, NC)
top10 <- rbind(state)
print(top10)
