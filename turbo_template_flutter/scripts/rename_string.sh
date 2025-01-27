#!/bin/bash

# Hardcoded values for replacement
OLD_STRING="AppSetup"
NEW_STRING="AppSetUp"

# Change to the lib directory where the Dart files are
cd "$(dirname "$0")/../lib" || exit 1

echo "Replacing all exact occurrences of '$OLD_STRING' with '$NEW_STRING'"
echo "This will only match exact strings (case-sensitive)"

# Find all files containing the exact string (excluding .git, build directories, and binary files)
FILES=$(grep -r -l --exclude-dir={.git,build,.dart_tool} --exclude=*.{lock,sh} "$OLD_STRING" .)

# Check if any files were found
if [ -z "$FILES" ]; then
    echo "No files found containing '$OLD_STRING'"
    exit 0
fi

# Show files that will be modified
echo -e "\nFiles to be modified:"
echo "$FILES"

# Ask for confirmation
read -p "Do you want to proceed with the replacement? (y/N) " -n 1 -r
echo

if [[ $REPLY =~ ^[Yy]$ ]]; then
    # Perform the replacement
    for file in $FILES; do
        # Use sed with escaped strings
        sed -i '' "s|$OLD_STRING|$NEW_STRING|g" "$file"
        echo "Updated: $file"
    done
    echo -e "\nReplacement complete!"
else
    echo "Operation cancelled"
fi
