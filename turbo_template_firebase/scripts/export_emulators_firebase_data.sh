#!/bin/bash

cd ../ || exit

echo "Exporting emulator data..."
firebase emulators:export exports 