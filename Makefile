PREFIX ?= 


.PHONY: all install


all:
	


install:
	if ! [ -e $(PREFIX)/etc/mklilithiso/templates ]; then \
		mkdir -p $(PREFIX)/etc/mklilithiso/templates; \
	fi
	cp -r ./templates/* $(PREFIX)/etc/mklilithiso/templates/
	install -Dm755 ./src/lithium $(PREFIX)/usr/sbin/lithium


uninstall:
	rm -rf $(PREFIX)/etc/mklilithiso
	rm -f $(PREFIX)/usr/sbin/lithium


