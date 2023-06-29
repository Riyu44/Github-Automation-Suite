# GitHub API credentials and repository information
GITHUB_USERNAME="Riyu44"
GITHUB_TOKEN=$token
REPO_LINK="https://github.com/Riyu44/Github-Automation-Suite"

# Path to the text file
TEXT_FILE=updates.txt
PACKAGE_JSON_FILE=package.json

# Extract owner and repository name from the GitHub repository link
REPO_OWNER=$(echo "$REPO_LINK" | awk -F'/' '{print $(NF-1)}')
REPO_NAME=$(echo "$REPO_LINK" | awk -F'/' '{print $NF}' | sed 's/.git$//')
echo "$REPO_OWNER"
echo "$REPO_NAME"

# Read the original package.json file
original_package_json=$(curl -s -u "$GITHUB_USERNAME:$GITHUB_TOKEN" "https://api.github.com/repos/$REPO_OWNER/$REPO_NAME/contents/$PACKAGE_JSON_FILE" | jq -r '.content' | base64 -d)

# Loop through each line in the text file
while IFS= read -r line; do
  # Extract package name and latest version using string manipulation or other methods
  package_name=$(echo "$line" | awk -F '[... ]' '{print $4}')
  latest_version=$(echo "$line" | awk '{print $(NF-1)}')
  echo "$package_name"
  echo "$latest_version"

  # Update the original package.json with the package and version changes
  original_package_json=$(jq --arg package "$package_name" --arg version "$latest_version" '.dependencies[$package] = $version' <<< "$original_package_json")

  # Wait for a few seconds to avoid rate limiting (if necessary)
  sleep 3
done < "$TEXT_FILE"

# Encode the updated package.json using base64
encoded_package_json=$(echo "$original_package_json" | base64 -w 0)

# Get the current SHA of the package.json file
current_sha=$(curl -s -u "$GITHUB_USERNAME:$GITHUB_TOKEN" "https://api.github.com/repos/$REPO_OWNER/$REPO_NAME/contents/$PACKAGE_JSON_FILE" | jq -r '.sha')

# Make a PUT request to the GitHub API to update the package.json file
curl -X PUT -u "$GITHUB_USERNAME:$GITHUB_TOKEN" \
  -H "Accept: application/vnd.github+json" \
  -d '{
    "message": "workflow2",
    "content": "'"$encoded_package_json"'",
    "sha": "'"$current_sha"'"
  }' "https://api.github.com/repos/$REPO_OWNER/$REPO_NAME/contents/$PACKAGE_JSON_FILE"
