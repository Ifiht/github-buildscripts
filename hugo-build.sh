#!/usr/bin/env bash

## Should start in project root
## Goto default hugo src dir
cd www
hugo --debug --minify
git add .
git commit -am "update prod"
git push --force
