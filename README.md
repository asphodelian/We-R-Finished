# We-R-Finished
## Overview
Welcome, you are currently in the official repository of We R Finished, a DS 311 group consisting Russel Chan, Ana Paula De Queiroz, Gabrielle Salamanca, and Catarina Tegtmeier. The chosen dataset they are going to explore, analyze, and present is the Data-Drive Industry Salary. 
## Documentation
1. [The google drive folder](https://drive.google.com/drive/folders/1M1jYp0MiyeWCBQHbs2pfAfvCYkD61lKU?usp=sharing)
*This folder holds all the group documentation and any necessary files we may need.*
> 2. [The overview doc](https://docs.google.com/document/d/1cgqEG4ZgZ36DACn_ysUwfLzuczyHDhThd7bskDm7z7E/edit?usp=sharing)
> *This doc holds the general overview of the project and includes the task assignments and meeting logs*
> 3. [The Salary Dataset Analysis Plan](https://drive.google.com/file/d/1aWo1OW4jSkv4NkUQj6zRNrlxvscYXNDf/view?usp=sharing)
## Instructions
1. Clone the repository to your local machine via git bash.
```
git clone <SSH>
OR
git clone <HTTPS>
cd<Repo Name>
```
2. Create and checkout the branch of this repository.
```
git branch <name of branch> # create new branch locally
git checkout <name of branch> # switch to the newly created branch
```
3. Start working on your task!
4. When you have made new files or modified them, add them to your branch.
```
git add . # add any update to the branch
git commit -m 'nessage for the update' # commit the change with a message
git log --all --graph # check the staging status in the new branch
```
When you are finished with your task, merge your branch to the main repository on Github.
```
git checkout main  # switch back to main branch locally
git merge <name of branch> -m "message for the update"  # merge the changes in new branch to main locally
git push -u origin <name of branch>  # push the change from new branch to the remote, namely "origin"
git log --all --graph  # check all the log status 
```
5. Create a pull request on Github.
Go back to the GitHub remote repository and check to see if the branch is created. Click on the **Pull Request** tab at the top of the repository, and click on the **New pull request** button.
