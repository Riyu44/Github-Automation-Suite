#Write a shell script to update the dependencies of a project from a updates.txt file
#The updates.txt file contains the list of dependencies to be updated in the format
while read line1
do

# Extracts the dependency from the echoed line
    line=$(sed -n 's/.*for \(.*\)... Latest .*/\1/p' <<< "$line1") 
    echo "Updating $line"

# Installs the dependencies
    npm install $line
done < updates.txt
