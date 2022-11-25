#!/bin/bash
instance='mootech'
version='4'
source "$(dirname $0)/test_wrapper.bash"

sanitized_multiline_sed "def suffix\n      ''" "def suffix\n      '+$instance$version'" ../lib/mastodon/version.rb

sanitized_sed '\(:concurrency:\) [0-9]' '\1 2' ../config/sidekiq.yml
