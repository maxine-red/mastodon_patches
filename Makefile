SHELL=/bin/bash
patch: add_themes add_languages change_version_and_config

add_themes:
	@ ./patch_files/themes.bash

add_languages:
	@ ./patch_files/languages.bash

change_version_and_config:
	@ ./patch_files/version_and_config.bash

unpatch: reset_repo gather_deletion_files
	cd .. && xargs rm -rv < deletion_files.txt && rm deletion_files.txt ; cd -

reset_repo:
	cd .. && git checkout . && cd -

gather_deletion_files:
	cd .. && git status | grep '/' | sed -e '/patches/d' > deletion_files.txt ; cd -

