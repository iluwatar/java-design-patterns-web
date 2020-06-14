#!/usr/bin/env bash

# clone the repositories we need
git clone https://github.com/iluwatar/30-seconds-of-java.git
git clone https://github.com/iluwatar/java-design-patterns.git patterns
git clone https://github.com/iluwatar/programming-principles.git

# add the currently used commit hash to the _config.yml so it can be displayed on the website
printf "\ngithub:\n  build_revision: " >> _config.yml
git log --pretty=format:'%H' -n 1 >> _config.yml

bundle exec jekyll build

# credit: code snippet borrowed from jekyllrb.com website source
IGNORE_HREFS=$(ruby -e 'puts %w{
    example\.com.*
    https:\/\/github.com\/iluwatar\/java-design-patterns\/fork
    https:\/\/sonarqube.com.*
}.map{|h| "/#{h}/"}.join(",")')
# - ignore example.com because they are just examples/fakes
# - ignore the fork link of our project, because it somehow is not valid (https://validator.w3.org/)
# - ignore sonarqube.com/api/badges/gate because of travis-only 'SSL Connect Error's

# - ignore everything below every webapp directory, so we dont mess with the source code
bundle exec htmlproofer ./_site/ --file-ignore "/.+\/(webapp)\/.*/" --url-ignore $IGNORE_HREFS --check-html --allow-hash-href --http-status-ignore "999"
