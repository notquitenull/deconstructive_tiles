VERSION=$(shell jq .version info.json)
DIRNAME=deconstructive_tiles_

all:
	-@rm -r deploy/* 
	-@mkdir deploy/$(DIRNAME)$(VERSION)
	cp -R -t deploy/$(DIRNAME)$(VERSION)/ \
		info.json \
		control.lua \
		data.lua \
		general.lua \
		prototypes \
		graphics
	cd deploy; zip -r $(DIRNAME)$(VERSION).zip $(DIRNAME)$(VERSION)/
	rm ~/.factorio/mods/$(DIRNAME)*
	cp deploy/$(DIRNAME)$(VERSION).zip ~/.factorio/mods/


