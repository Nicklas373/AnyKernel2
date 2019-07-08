NAME := Clarity-Kernel

DATE := $(shell date "+%Y%m%d-%H%M")

VER := r2-EAS

CODE := Mido

ZIP := $(NAME)-$(CODE)-$(VER)-$(DATE).zip

ZIP_SIGN := $(NAME)-$(CODE)-$(VER)-$(DATE)-signed.zip

ZIP_SHA := $(NAME)-$(CODE)-$(VER)-$(DATE).zip.sha1

EXCLUDE := Makefile *.git* *.jar* *placeholder* *.md* *.pem* *.pk8* *.jar* *.sha1*

normal: $(ZIP)

$(ZIP):
	@echo "Creating ZIP: $(ZIP)"
	@zip -r9 "$@" . -x $(EXCLUDE)
	@java -jar signapk.jar signature-key.Nicklas@XDA.x509.pem signature-key.Nicklas@XDA.pk8 $(ZIP) $(ZIP_SIGN)
	@echo "Generating SHA1..."
	@sha1sum "$@" > "$@.sha1"
	@cat "$@.sha1"
	@echo "Done."
	@rm $(ZIP)
	@mv $(ZIP_SIGN) $(HOME)
	@mv $(ZIP_SHA) $(HOME)
