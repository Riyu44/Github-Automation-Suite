# Checks if UPD tag is found in the latest comment or not; if found, it creates the file with needed updates
touch updates.txt
file="update_requirement.txt"
check=0
while IFS= read -r line || [ -n "$line" ]; do
line=$(echo "$line" | awk '{$1=$1};1')
  if [[ "$line" == "~UPD" && $check -eq 0 ]]; then
    echo "Flag UPD found in the first line. Performing actions..."
    check=1
  elif [[ $check -eq 0 ]]; then
    echo "Flag ~UPD not found. Aborting..."
    break
  else
    echo "$line" >> updates.txt
  fi
done < "$file"
