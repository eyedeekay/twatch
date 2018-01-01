
export PREFIX=/usr/local/
export DIR=lib/twatch
export SETTINGS=/etc/twatch


export CFLAGS=-lz -ldl -static -static-libgcc -lcrypto -I$(shell pwd)/openssl-1.0.2e/include/
export EXTRA_CFLAGS=-lz -ldl -static -static-libgcc -lcrypto -I$(shell pwd)/openssl-1.0.2e/include/
export LIBS=-L$(shell pwd)/openssl-1.0.2e/

usage:

clean:
	rm -rf *.tar.gz* *.zip* *.cap* *.deauth* *.mac* *.log* *.err* \
		routers.txt macs.txt hostapd-wpe-master

clobber: clean
	rm -rf hostapd-2.6 hostapd-wpe

mrfresh: clean clobber
	rm -rf openssl-1.0.2e

install:
	mkdir -p "$(PREFIX)$(DIR)" "$(PREFIX)$(DIR)/tshark" "$(PREFIX)$(DIR)/bashsimplecurses-1.2/"
	cp aliases.sh "$(PREFIX)$(DIR)"
	cp global.conf "$(SETTINGS)"
	cp bashsimplecurses-1.2/simple_curses.sh "$(PREFIX)$(DIR)/bashsimplecurses-1.2/"
	cp bashsimplecurses-1.2/AUTHORS "$(PREFIX)$(DIR)/bashsimplecurses-1.2/"
	cp bashsimplecurses-1.2/INSTALL "$(PREFIX)$(DIR)/bashsimplecurses-1.2/"
	cp bashsimplecurses-1.2/LICENSE "$(PREFIX)$(DIR)/bashsimplecurses-1.2/"
	cp bashsimplecurses-1.2/README "$(PREFIX)$(DIR)/bashsimplecurses-1.2/"
	cp bashsimplecurses-1.2/Makefile "$(PREFIX)$(DIR)/bashsimplecurses-1.2/"
	cp tshark/tshark.conf "$(PREFIX)$(DIR)/tshark"
	cp tshark/tshark-functions.sh "$(PREFIX)$(DIR)/tshark"
	cp tshark/tshark-watch.sh "$(PREFIX)$(DIR)/tshark"


dep: bashsimplecurses-1.2.tar.gz
	tar xvzf bashsimplecurses-1.2.tar.gz; rm bashsimplecurses-1.2.tar.gz

bashsimplecurses-1.2.tar.gz:
	wget -c https://github.com/metal3d/bashsimplecurses/releases/download/v1.2/bashsimplecurses-1.2.tar.gz


openssl-1.0.2e:
	wget https://www.openssl.org/source/old/1.0.2/openssl-1.0.2e.tar.gz
	#wget https://www.openssl.org/source/old/1.1.0/openssl-1.0.2e.tar.gz
	tar xvf openssl-1.0.2e.tar.gz
	cd openssl-1.0.2e && \
		./config no-shared enable-heartbeats enable-tls1 enable-tls enable-ssl3 enable-ssl
	cd openssl-1.0.2e && \
		make depend && \
		make

openssl: openssl-1.0.2e

hostapd-wpe: hostapd-2.6 openssl
	wget https://github.com/OpenSecurityResearch/hostapd-wpe/archive/master.zip
	unzip master.zip && mv hostapd-wpe-master hostapd-wpe
	cd hostapd-2.6/ && \
		patch -p1 < ../hostapd-wpe/hostapd-wpe.patch

hostapd-2.6:
	wget http://hostap.epitest.fi/releases/hostapd-2.6.tar.gz
	tar -zxf hostapd-2.6.tar.gz

hostapd-build:
	cd hostapd-2.6/hostapd/ && \
		make

hostapd: hostapd-2.6 openssl-1.0.2e hostapd-wpe hostapd-build



