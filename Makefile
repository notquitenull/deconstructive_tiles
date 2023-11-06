all:
	-@rm -r deploy/* 
	@mkdir deploy/deconstructive_tiles_0.0.1
	cp -R -t deploy/deconstructive_tiles_0.0.1/ \
		info.json \
		control.lua \
		data.lua \
		general.lua \
		prototypes \
		graphics
	cd deploy; zip -r deconstructive_tiles_0.0.1.zip deconstructive_tiles_0.0.1/
	cp deploy/deconstructive_tiles_0.0.1.zip ~/.factorio/mods/


