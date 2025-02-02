#!/bin/bash

cd ../
git fetch turbo_template
git checkout turbo_template/main_turbo -- lib/turbo/ scripts/ analysis_options.yaml assets/
