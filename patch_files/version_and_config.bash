#!/bin/bash
instance='mootech'
version='4'
source "$(dirname $0)/test_wrapper.bash"

sed -i -e '1h;2,$H;$!d;g' -e "s/\(def suffix\n      \)'[^']\+'/\1'+$instance$version'/" ../lib/mastodon/version.rb

sed -i -e 's/\(:concurrency:\) [0-9]/\1 2/' ../config/sidekiq.yml
