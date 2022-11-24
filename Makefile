SHELL=/bin/bash
patch:
	@ ./patch_files/themes.bash
	@ ./patch_files/languages.bash
	@ ./patch_files/version_and_config.bash
