#!/bin/bash

cd ../
git fetch turbo_template
git checkout 63de9f3 -- firestore.rules firestore.indexes.json
