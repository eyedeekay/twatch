
export PREFIX=/usr/local/
export DIR=lib/twatch
export SETTINGS=/etc/twatch

usage:

clean:
	rm -f *.cap *.deauth *.mac *.log routers.txt macs.txt

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



