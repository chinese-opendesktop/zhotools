VERSION = 0.5
DESTDIR =
PREFIX = /usr
PACKAGE = zhotools

.PHONY: all
all: zhocompose.sqlite zhoortho.sqlite zhorelate.sqlite zhotrans.sqlite zhottp.sqlite

%.sqlite:
	bash ssv2sqlite.sh $*

.PHONY: clean
clean:
	rm -f *.sqlite

.PHONY: install
install: all
	install -d $(DESTDIR)$(PREFIX)/bin
	install -m 755 zhocompose zhorelate zhottp zhotrans zhoortho $(DESTDIR)$(PREFIX)/bin
	install -d $(DESTDIR)$(PREFIX)/share/$(PACKAGE)
	install -m 644 *.sqlite $(DESTDIR)$(PREFIX)/share/$(PACKAGE)

.PHONY: uninstall
uninstall:
	rm -f $(DESTDIR)$(PREFIX)/bin/zhocompose
	rm -f $(DESTDIR)$(PREFIX)/bin/zhorelate
	rm -f $(DESTDIR)$(PREFIX)/bin/zhottp
	rm -f $(DESTDIR)$(PREFIX)/bin/zhotrans
	rm -f $(DESTDIR)$(PREFIX)/bin/zhoortho
	rm -rf $(DESTDIR)$(PREFIX)/share/$(PACKAGE)

rpm:
	rm -rf $(HOME)/rpmbuild/SOURCES/$(PACKAGE)-$(VERSION)
	cp -af ../$(PACKAGE) $(HOME)/rpmbuild/SOURCES/$(PACKAGE)-$(VERSION)
	sed -i 's/@VERSION@/$(VERSION)/' $(HOME)/rpmbuild/SOURCES/$(PACKAGE)-$(VERSION)/$(PACKAGE).spec
	sed -i '/rpm:/,$$d' $(HOME)/rpmbuild/SOURCES/$(PACKAGE)-$(VERSION)/Makefile
	tar czvf $(HOME)/rpmbuild/SOURCES/$(PACKAGE)-$(VERSION).tar.gz -C $(HOME)/rpmbuild/SOURCES $(PACKAGE)-$(VERSION)
	rpmbuild -ta $(HOME)/rpmbuild/SOURCES/$(PACKAGE)-$(VERSION).tar.gz
