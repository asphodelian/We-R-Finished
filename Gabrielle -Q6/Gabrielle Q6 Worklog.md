# Gabrielle Work Log

[Work Log Doc](https://docs.google.com/document/d/1SmR8a8j9Hdqpzv-xET0yI8C1_jGyZ_VTP8Bp-1U7CSQ/edit?usp=sharing)

## Apr 13, 2023
- Cost of Living 2023 
	- Will start new branch
	- Begin EDA
	- Q6 Development
- RMD of Q6
	- Loaded necessary libraries
	- Dataset
		- Read
		- Filtered out fips
	- Columns → variables
	- Make top10 dataframe
		- Seems like TX doesn’t like trying to be read
		- At first assuming it’s because i named the filtered dataset as col
		- Therefore it’s reading it somehow like column? Or something similar
		- So renamed as coldf & changed the necessary lines
		- Apparently not, always have to run previous chunks to make it run ok
			- Not sure what problem is
		- Dataframe readability difficulty, will need to try something else

## Apr 20, 2023
- Trying to filter Q6 data
	- Figured it out after getting logical subscript errors
	- Top 10 states
- Cost index comparison
	- Checking if getting avg = true cost
- Will add on russel’s code for handling COL & salary dataset
	- Will use for Q6 for new dataset
	- Will also even out numbers
- Starting Q6 RMD
	- Main question I want to answer
	- Definition of standard/cost of living
	- Why is it important
	- About the CoL dataset
		- Prepping it for question
	- Filtering & merging CoL & salary dataset 

## Apr 25, 2023
- Q6
	- Changed average/mean to median
		- Ana’s suggestion 
		- More stable to previous 
	- Changed paid wage/yr to adjusted wage 
		- Realized because adjusted is the one I'm actually looking at
		- Not paid wage 

## Apr 26, 2023
- Q6
	- Did all of the above  into PC
	- Added ana’s median paid/adjusted wage
		- Had to troubleshoot

## May 4, 2023
- Meeting with ana & russell
	- Q6 task clarification
		- Removed diving in part
		- Will leave write-up to ana/russell
- Pushing my Q6 branch upstream
	- Accidentally merged to main
	- Deleted from repo & locally
	- Making new branch with all og files 
		- Will push that instead


