#!/usr/bin/env bash

# Env setup
## Should start in project root
pwd
git config --global user.email "peter@never.lan"
git config --global user.name "Peter Pan"

# Deploy actions
git fetch
git checkout prod
git reset --hard main