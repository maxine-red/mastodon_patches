#!/bin/bash

echo "Remember that new users will have the new language 'en-MO' as their
default language, but old users keep their set default language."
echo "Please instruct your users to change accordingly."
echo "If this is an update process, the above notice can be ignored."

cp app/javascript/mastodon/locales/* ../app/javascript/mastodon/locales
cp config/locales/* ../config/locales

sed -ie 's/request_locale || I18n.default_locale/case request_locale\n      when \/en\\b\/, nil\n        I18n.default_locale\n      else\n        request_locale\n      end/' ../app/controllers/concerns/localized.rb

add_locale () {
  if ! grep -q "$2" $3; then
    sed -i -e "s/$1/\0\n$2/" $3
  fi
}
add_locale "en: 'English'," "    'en-MO': 'English (Moo)'," ../app/helpers/settings_helper.rb
add_locale ":en," "      :'en-MO'," ../config/application.rb
add_timeformat () {
  if ! grep -q "$2" $3; then
    sed -i -e "s/$1/$2\n\0/" $3
  fi
}
add_timeformat "export const timeAgoString = " \
  "const fallbackFormat = new Intl.DateTimeformat('en', shortDateFormatOption);" \
  ../app/javascript/mastodon/components/relative_timestamp.js
sed -i -e '1h;2,$H;$!d;g' -e "s/unless config.i18n.available_locales.include?(config.i18n.default_locale)\n      config.i18n.default_locale = :en\n    end/if config.i18n.available_locales.include?(config.i18n.default_locale)\n      config.i18n.fallbacks = [:en]\n    else\n      config.i18n.default_locale = :'en-MO'\n      config.i18n.fallbacks = [:en]\n    end/" ../config/application.rb

