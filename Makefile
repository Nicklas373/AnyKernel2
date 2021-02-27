NAME := Fusion-Kernel-for-lavender

CODE := Lavender

ZIP := $(NAME)-$(CODE)-signed.zip

EXCLUDE := Makefile LICENSE *.git* *placeholder* *.md*

normal: $(ZIP)

$(ZIP):
	@echo "Creating ZIP: $(ZIP)"
	@zip -r9 "$@" . -x $(EXCLUDE)
	@echo "Done."
