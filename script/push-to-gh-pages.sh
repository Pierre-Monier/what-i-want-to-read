#!/bin/bash

cd website/_site
git init
git config --global user.email pierre.monier.dev@gmail.com
git config --global user.name Pierre-Monier
git status
git remote add origin "https://$1@github.com/Pierre-Monier/what-i-want-to-read.git"
git checkout -b gh-pages
git add --all
git commit -m "update"
git push origin gh-pages -f