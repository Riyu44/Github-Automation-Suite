#GET the contributors list from GIT Hub
REPO="Sopra-Banking-Software-Interns/Github-Learderboard"
curl -s -L \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer $token"\
  -H "X-GitHub-Api-Version: 2022-11-28" \
  https://api.github.com/repos/Sopra-Banking-Software-Interns/unified-automation-suite/contributors | jq -r '.[] | {login, contributions}' >> contributions.txt

#Create a new game on the leaderboard on Cloud storage
ID=$(curl -s -X POST -H "Content-Type: application/json" -d '{"name": "$REPO"}' https://us-central1-js-capstone-backend.cloudfunctions.net/api/games/ | jq -r '.result | scan("Game with ID: (.+) added.")[]')

#POST the contributors list to the leaderboard
echo $ID
jq -s '.' contributions.txt >> contributions.json
rm contributions.txt

sed 's/login/user/g; s/contributions/score/g' contributions.json > contribution_final.json
rm contributions.json

# Create a database for the leaderboard
# Read the JSON file into a variable
json=$(cat contribution_final.json)
OWNER="Sopra-Banking-Software-Interns"
REPO="unified-automation-suite"

# Make a request to fetch closed issues of a contributor
response=$(curl -s -L \
   -H "Accept: application/vnd.github+json" \
   -H "Authorization: Bearer $token" \
   -H "X-GitHub-Api-Version: 2022-11-28" \
     "https://api.github.com/repos/$OWNER/$REPO/issues?state=closed")


# Extract the array elements using jq
elements=$(echo "$json" | jq -c '.[]')
# Iterate over the array elements
while IFS= read -r element; do
    curl --location "https://us-central1-js-capstone-backend.cloudfunctions.net/api/games/$ID/scores/" \
    --header 'Content-Type: application/json' \
    --data "$element"
done <<< "$elements"

# sed command to delete an instance between <!--START_TABLE-->/, /<!--END_TABLE--> to update new table
sed -i '/<!--START_TABLE-->/, /<!--END_TABLE-->/d' README.md

#Storing Previous IDs (cloud Version control)
echo "- [$(date)](https://us-central1-js-capstone-backend.cloudfunctions.net/api/games/$ID/scores/)" >> README.md


# Storing Html url of solved issues for every user in a cloud through cloud API
# Created issues.json which contains issue no.s solved for every user 
touch temp.txt
jq '.[] | .user' "contribution_final.json" > temp.txt
linenumber=$(sed -n '$=' temp.txt)
touch issue.txt
for (( x=1; x<=$linenumber; x++ ))
do
linew=$(sed -n "${x}p" temp.txt)
echo "{\"user\":$linew," >>issue.txt
echo "\"issues\":" >>issue.txt
arr[x-1]=$(echo $response | jq "[.[] | select(.user.login==$linew) | .url] | length")
echo $response | jq -r ".[] | select(.user.login==$linew) | .html_url" > url.txt
sed -i 's/$/,/' url.txt
txt=$(tr -d '\n' < url.txt)
echo "{\"URL\":\"$txt\",\"testPayload\": true,\"keysLength\": 3}" >data1.json
linew=$(echo $linew | tr -d '"')
curl --location "https://getpantry.cloud/apiv1/pantry/$pantry/basket/$linew" \
--header 'Content-Type: application/json' \
--data @data1.json
rm url.txt
rm data1.json
echo "${arr[x-1]}}" >> issue.txt
done
jq -s '.' issue.txt > issue.json
rm issue.txt

# Combined issues.json with contribution_final.json thus making our json data with 3 fields(User,contributions,solved issues) for an object
echo "$(jq -s 'group_by(.[].user) | map(add)[]' contribution_final.json issue.json)" > data.json
echo "$(jq 'group_by(.user) | map(add)[]' data.json)" > final.txt
jq -s '.' final.txt > contribution_final.json
json_data=$(cat contribution_final.json)
rm final.txt
rm issue.json
rm data.json
rm temp.txt
# sorted the table
json_data=$(echo "$json_data" | jq -r '. | sort_by(-.score)')

# Creating the markup language from Readme
echo "<!--START_TABLE-->" >> README.md
echo "| Login        | Contributions | Solved Issues |
| ------------ | ------------- | ------------- |" >> README.md
# Loop through JSON array and write markup language format to make a table out of user, contributions & issues. Also stored embedded links
echo "$json_data" | jq -r ".[] | \"| \(.user) | [\(.score)](https://github.com/Sopra-Banking-Software-Interns/Github-Leaderboard/commits?author=\(.user)) | [\(.issues)](https://getpantry.cloud/apiv1/pantry/$pantry/basket/\(.user)) |\"" >> README.md
echo "<!--END_TABLE-->" >> README.md
