VERSION=0.3
DESTDIR=
PREFIX=/usr
PACKAGE=zhotools

all:

install:
	install -d $(DESTDIR)$(PREFIX)/bin
	install -m 755 zhocompose zhorelate zhottp zhotrans zhoortho $(DESTDIR)$(PREFIX)/bin
	install -d $(DESTDIR)$(PREFIX)/share/$(PACKAGE)
	install -m 644 *.ssv $(DESTDIR)$(PREFIX)/share/$(PACKAGE)

uninstall:
	rm -f $(DESTDIR)$(PREFIX)/bin/zhocompose
	rm -f $(DESTDIR)$(PREFIX)/bin/zhorelate
	rm -f $(DESTDIR)$(PREFIX)/bin/zhottp
	rm -f $(DESTDIR)$(PREFIX)/bin/zhotrans
	rm -f $(DESTDIR)$(PREFIX)/bin/zhoortho
	rm -rf $(DESTDIR)$(PREFIX)/share/$(PACKAGE)

