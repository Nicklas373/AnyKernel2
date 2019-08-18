NAME := Clarity-Kernel

CODE := Mido

ZIP := $(NAME)-$(CODE).zip

ZIP_SIGN := $(NAME)-$(CODE)-signed.zip

EXCLUDE := Makefile *.git* *.jar* *placeholder* *.md* *.pem* *.pk8* *.jar* *.sha1*

normal: $(ZIP)

$(ZIP):
	@echo "Creating ZIP: $(ZIP)"
	@zip -r9 "$@" . -x $(EXCLUDE)
	@java -jar signapk.jar signature-key.Nicklas@XDA.x509.pem signature-key.Nicklas@XDA.pk8 $(ZIP) $(ZIP_SIGN)
	@echo "Done."
