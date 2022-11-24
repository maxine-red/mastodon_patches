#!/bin/bash
append () {
  file='../config/themes.yml'
  if ! grep -q "$1" $file; then
    echo "$1" >> $file
  fi
}
append 'Moostodon: styles/moostodon.scss'
append 'Pupper: styles/pupper.sccs'

cp -r app/javascript/styles/moostodon* app/javascript/styles/pupper* \
  ../app/javascript/styles
cp public/favicon.ico ../public
