#!/usr/bin/env bash
URI_STRING='loyalistresearchnet.org'
SLUG_STRING='loyaltres'
UUID_STRING='3083'

rm -rf .git

find . -type f -print0 | xargs -0 sed -i.bak "s/loyalistresearchnet.org/$URI_STRING/g"
find . -type f -print0 | xargs -0 sed -i.bak "s/loyaltres/$SLUG_STRING/g"
find . -type f -print0 | xargs -0 sed -i.bak "s/3083/$UUID_STRING/g"
find . -name "*.bak" -type f -delete

rm README.md
mv README.repo.md README.md

git init
git add .
git add -f ./config-yml/.gitkeep
git add -f ./custom/modules/.gitkeep
git add -f ./custom/themes/.gitkeep

git commit -m 'Initial commit from template repo.'
