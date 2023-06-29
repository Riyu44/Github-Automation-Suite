
## Unified-Automation-Suite

This repository contains a combination of three workflows, combined into a single unified Github automation suite. To use the automation suite, you can look into the deployment section.
This workflow has the following components:
 - #### Github Leaderboard
   Github leaderboard utilizes two cloud storage components to keep track of individual contributions and incidents. These contributions can further be linked to other endpoints and act as a microservice on a bigger architecture.

- #### Incident Creation
  Incident creation workflow utilizes the depencies folder and creates incidents if the version being used currently is outdated. Currently the workflow is configured for package.json and npm modules.

- #### Incident Closure
  Once the incident is created, this workflow waits for its closure. Once the isse is closed using '~UPD' tag, followed by updates needed, it updates all the dependencies to their latest version on the deployment server (Currently on the Github runner on which the scripts are ran).

All the three workflows run using CI-CD pipeline and Github actions and thus, can act as an add-on to any existing repos.
## Deployment

To deploy this project on your github repo, follow the steps below:

```
  Open the shell scripts and rename the REPO url variable.
```
```
  Create a repository variable named ACCESS_TOKEN
```
```
  Put your access token in the variable value
```
```
  Change the git-hub config email in the scripts
```
You are good to go.
## Authors/Collaborators

- [@Riyu44](https://www.github.com/Riyu44)
- [@Tushar-25](https://github.com/Tushar-2510)
- [@Suvarchala-30](https://github.com/Suvarchala-30)
- [@CodePrakhar](https://github.com/CodePrakhar)
- [@navvay](https://github.com/navvay)


## Github-Leaderboard- 
Here's a list of all the previous data tables, hosted over cloud storage
- [Tue Jun 27 10:03:14 UTC 2023](https://us-central1-js-capstone-backend.cloudfunctions.net/api/games/rJolRAZEFEymHsugSTPL/scores/)
- [Wed Jun 28 05:09:39 UTC 2023](https://us-central1-js-capstone-backend.cloudfunctions.net/api/games/eF55weuWOKuMohABct2a/scores/)
- [Wed Jun 28 07:29:07 UTC 2023](https://us-central1-js-capstone-backend.cloudfunctions.net/api/games/0bvQIEFsiL3tvjWrSKcG/scores/)
- [Wed Jun 28 07:30:58 UTC 2023](https://us-central1-js-capstone-backend.cloudfunctions.net/api/games/QhhEgXRm9XKo3cANaXWU/scores/)
- [Wed Jun 28 09:08:49 UTC 2023](https://us-central1-js-capstone-backend.cloudfunctions.net/api/games/QYXQYvGizCzAFdzGfdCd/scores/)
- [Wed Jun 28 09:12:07 UTC 2023](https://us-central1-js-capstone-backend.cloudfunctions.net/api/games/ggw17MtHhpn3xWfSC4XR/scores/)
- [Wed Jun 28 09:45:47 UTC 2023](https://us-central1-js-capstone-backend.cloudfunctions.net/api/games/ruNvbk47EY6EpoAoNQiL/scores/)
- [Wed Jun 28 09:46:19 UTC 2023](https://us-central1-js-capstone-backend.cloudfunctions.net/api/games/e9OCT9Tui7F2d1ivJt0H/scores/)
- [Wed Jun 28 09:47:02 UTC 2023](https://us-central1-js-capstone-backend.cloudfunctions.net/api/games/P5v4dqRRZY2IqWg3gZWO/scores/)
- [Wed Jun 28 09:47:40 UTC 2023](https://us-central1-js-capstone-backend.cloudfunctions.net/api/games/bsnyL5dGVEtwLa0g2NQN/scores/)
<!--START_TABLE-->
| Login        | Contributions | Solved Issues |
| ------------ | ------------- | ------------- |
| Riyu44 | [136](https://github.com/Sopra-Banking-Software-Interns/Github-Leaderboard/commits?author=Riyu44) | [30](https://getpantry.cloud/apiv1/pantry/860a0c02-c763-41ca-9d31-ec787fc3202a/basket/Riyu44) |
| Tushar-2510 | [99](https://github.com/Sopra-Banking-Software-Interns/Github-Leaderboard/commits?author=Tushar-2510) | [0](https://getpantry.cloud/apiv1/pantry/860a0c02-c763-41ca-9d31-ec787fc3202a/basket/Tushar-2510) |
| CodePrakhar | [4](https://github.com/Sopra-Banking-Software-Interns/Github-Leaderboard/commits?author=CodePrakhar) | [0](https://getpantry.cloud/apiv1/pantry/860a0c02-c763-41ca-9d31-ec787fc3202a/basket/CodePrakhar) |
<!--END_TABLE-->
