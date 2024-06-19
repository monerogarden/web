#!/bin/bash

# This is a util script to ensure same naming strategy is applied to all files and references inside the text.

# Check if the directory argument is provided
if [ -z "$1" ]; then
    echo "Usage: $0 DIRECTORY"
    exit 1
fi

# Directory containing the markdown files
DIR="$1"

# Check if the provided argument is a valid directory
if [ ! -d "$DIR" ]; then
    echo "Error: $DIR is not a valid directory."
    exit 1
fi

# Rename the files by replacing the first '-' after the xx.yy ine with '_'
find "$DIR" -type f -name '*.md' | while read -r file; do
    # Extract the directory and filename
    dir=$(dirname "$file")
    filename=$(basename "$file")
    
    # Ensure filename is lowercase and replace '-' with '_'
    new_filename=$(echo "$filename" | tr 'A-Z' 'a-z' | tr '-' '_')
    
    # Remove irrelevant `0` after the period
    new_filename=$(echo "$new_filename" | sed -E 's/([0-9]+)\.0*([0-9]+)_/\1.\2_/')
    
    # If the new filename is different from the current filename, rename the file
    if [ "$filename" != "$new_filename" ]; then
        echo "mv $file $dir/$new_filename"
        mv "$file" "$dir/$new_filename"
    fi
done

# # Find all references to `.md` files in all mardown files from DIR and
# replace all `-` for `_` in the filename
find "$DIR" -type f -name '*.md' | while read -r file; do
    echo "Updating contents for $file"
    # Read the content of the file line by line
    while IFS= read -r line; do
        # Replace the filename in markdown links
        updated_line=$(echo "$line" | sed -E 's/(\[[^\]]*\]\()([a-zA-Z0-9_.-]+)(\.md\))/\1\2\3/g' | \
            sed -E 's/(\[[^\]]*\]\()([a-zA-Z0-9_.-]*-+[a-zA-Z0-9_.-]*)(\.md\))/\1\2\3/g' | \
            sed -E 's/(\[[^\]]*\]\()([a-zA-Z0-9_]*)-([a-zA-Z0-9_]*)(\.md\))/\1\2_\3\4/g' | \
            sed -E 's/(\[[^\]]*\]\()([a-zA-Z0-9_.-]+)(\.md\))/\1\2\3/g' | \
            sed -E 's/(\[[^\]]*\]\()([A-Z])+([a-zA-Z0-9_.-]*)(\.md\))/\1\L\2\3\4/g' | \
        sed -E 's/(\[[^\]]*\]\()([0-9]+)\.0*([0-9]+)_([a-zA-Z0-9_.-]*)(\.md\))/\1\2.\3_\4\5/g')
        
        # Print the updated line
        echo "$updated_line"
    done < "$file" > "$file.tmp"
    
    # Replace the original file with the updated one
    mv "$file.tmp" "$file"
done
