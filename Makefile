VERSION = 0.4
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

