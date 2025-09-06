#/usr/bin/env bash

# Copy the following under each line of the file given in the argument
#  - ID :
#  - Level :
#  - Method :
#  - Assessment Status :
#  - Checking command :
#  - Setting command :
#  - DefaultValue :
#  - RecommendedValue :
#  - TypeValue :

# Copy the pattern under each line of the given file and write the values to a new file
if [ -z "$1" ]; then
    echo "Please provide the file name"
    exit 1
fi

file=$1
new_file="new_$file"
touch $new_file

while IFS= read -r line
do
    echo "$line" >> $new_file
    echo "  - ID :" >> $new_file
    echo "  - Level :" >> $new_file
    echo "  - Method :" >> $new_file
    echo "  - Assessment Status :" >> $new_file
    echo "  - Checking command :" >> $new_file
    echo "  - Setting command :" >> $new_file
    echo "  - DefaultValue :" >> $new_file
    echo "  - RecommendedValue :" >> $new_file
    echo "  - TypeValue :" >> $new_file
done < "$file"

echo "New file created: $new_file"
exit 0
