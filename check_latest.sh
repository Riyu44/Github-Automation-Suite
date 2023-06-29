# checks the latest version for the dependencies

#reads the dependency file
truncate -s 0 version_changes.txt
json=$(cat dependencies.json | jq '.dependencies')
echo "$json" | jq -c 'to_entries[]' | while IFS= read -r element; do
    key=$(echo "$element" | jq -r '.key')
    value=$(echo "$element" | jq -r '.value')
    # echo "Key: $key, Value: $value"
    
# Finds the latest version of the dependencies available
    cur=$(npm show $key version)
    # echo $cur
# If the version is outdated it generates a message for the updates available
    if [ "$cur" != "$value" ] && [ "^$cur" != "$value" ]; then
        echo "Update available for $key... Latest $cur available">>version_changes.txt
    fi
done

rm -f dependencies.json
