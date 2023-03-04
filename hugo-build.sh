#!/usr/bin/env bash

# Env setup
git config --global user.email "peter@never.lan"
git config --global user.name "Peter Pan"

# Deploy actions
git fetch
git checkout prod
git reset --hard main
cd www
hugo --debug --minify
git add .
git commit -am "update prod"
git push --force
