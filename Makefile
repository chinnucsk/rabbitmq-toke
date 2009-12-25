PACKAGE:=rabbitmq-toke
DEPS:=rabbitmq-server
TOKE_DIR:=toke
PRIV_DIR:=priv

include ../include.mk

clean::
	rm -rf $(PRIV_DIR)
	if [ -e $(TOKE_DIR)/Makefile ]; then make -C $(TOKE_DIR) clean; fi

update: toke
	(cd $(TOKE_DIR); hg pull; hg up -C default)

toke:
	hg clone http://hg.opensource.lshift.net/toke

toke_build: toke
	make -C $(TOKE_DIR)
	cp -r $(TOKE_DIR)/$(EBIN_DIR) .
	cp -r $(TOKE_DIR)/$(PRIV_DIR) .

$(TARGETS): toke_build

.PHONY: toke_build
