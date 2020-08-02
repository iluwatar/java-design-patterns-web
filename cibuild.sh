#!/usr/bin/env bash

# clone the repositories we need
git clone https://github.com/iluwatar/30-seconds-of-java.git
git clone https://github.com/iluwatar/java-design-patterns.git patterns
git clone https://github.com/iluwatar/programming-principles.git

# add the currently used commit hash to the _config.yml so it can be displayed on the website
printf "\ngithub:\n  build_revision: " >> _config.yml
git log --pretty=format:'%H' -n 1 >> _config.yml

bundle exec jekyll build
