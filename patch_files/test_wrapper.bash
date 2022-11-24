#!/bin/bash

sanitized_sed () {
  if grep -q "$1" $3; then
    sed -i -e "s/$1/$2/" $3
  else
    not_found "$1" "$3"
  fi
}

sanitized_multiline_sed () {
  if ruby "$(dirname $0)/tester.rb" "$1" $3; then
    sed -i -e '1h;2,$H;$!d;g' -e "s/$1/$2/" $3
  else
    not_found "$1" "$3"
  fi
}

not_found () {
  echo "Pattern '$1' not found in $3! Please check code."
  exit 1
}
