#!/bin/bash

cd ../
git fetch turbo_template
git checkout tags/v0.0.1 -- lib/turbo/ scripts/ analysis_options.yaml assets/
