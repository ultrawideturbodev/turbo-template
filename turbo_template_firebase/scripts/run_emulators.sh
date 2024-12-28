#!/bin/bash

# Kill any running firebase emulators
echo "Killing any running firebase emulators..."
lsof -t -i:9099 -i:5001 -i:8080 -i:9199 | while read -r pid; do
    if ps -p $pid -o command | grep -q "firebase"; then
        kill -9 $pid 2>/dev/null || true
    fi
done

# Navigate to functions directory and do a clean build
cd ../functions || exit
rm -rf lib/
npm run build

cd ../ || exit

if [ -d "exports/firestore_export" ] || [ -f "exports/auth_export.json" ]; then
    echo "Starting emulators with data import..."
    firebase emulators:start --import=exports
else
    echo "No exports found, starting clean emulators..."
    firebase emulators:start
fi 