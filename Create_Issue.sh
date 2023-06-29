#!/bin/bash

# GitHub repository URL
REPO_URL="https://github.com/Riyu44/Github-Automation-Suite"

# GitHub personal access token
GITHUB_TOKEN=$token

# Issue title and body
ISSUE_TITLE="Available version updates"

mapfile -t lines < version_changes.txt

# Concatenate the lines into the issue body
ISSUE_BODY=""
for line in "${lines[@]}"; do
  ISSUE_BODY+="\n$line"
done

# Extract the owner and repository name from the URL
REPO_OWNER=$(echo "$REPO_URL" | awk -F/ '{print $(NF-1)}')
REPO_NAME=$(echo "$REPO_URL" | awk -F/ '{print $NF}' | sed 's/.git$//')

# Get the list of repository owners
owners_response=$(curl -H "Authorization: Bearer $GITHUB_TOKEN" \
  -H "Accept: application/vnd.github.v3+json" \
  "https://api.github.com/repos/$REPO_OWNER/$REPO_NAME/collaborators?affiliation=owner")

# Check if the response is valid JSON
if ! jq -e . >/dev/null 2>&1 <<<"$owners_response"; then
  echo "Failed to get repository owners"
  echo "API response:"
  echo "$owners_response"
  exit 1
fi

# Extract the usernames of the owners
usernames=$(echo "$owners_response" | jq -r '.[].login')

# Select a random owner
random_owner=$(shuf -e $usernames | head -n 1)

# Create the issue using the GitHub API
issue_response=$(curl -H "Authorization: Bearer $GITHUB_TOKEN" \
  -H "Accept: application/vnd.github.v3+json" \
  -d "{\"title\":\"$ISSUE_TITLE\",\"body\":\"$ISSUE_BODY\",\"assignees\":[\"$random_owner\"]}" \
  "https://api.github.com/repos/$REPO_OWNER/$REPO_NAME/issues")

# Check if the response is valid JSON
if ! jq -e . >/dev/null 2>&1 <<<"$issue_response"; then
  echo "Failed to create the issue"
  echo "API response:"
  echo "$issue_response"
  exit 1
fi

# Extract the issue number from the response
issue_number=$(echo "$issue_response" | jq -r '.number')

# Check if the issue number is null
if [[ "$issue_number" == "null" ]]; then
  echo "Failed to create the issue"
  echo "API response:"
  echo "$issue_response"
  exit 1
fi

# Display the created issue number and the assigned owner
echo "New issue created: #$issue_number"
echo "Assigned to: $random_owner"
