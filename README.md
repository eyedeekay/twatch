twatch
======

Shared settings and helper functions for monitoring nearby activity via the
terminal.

Before using, you'll need to download bashsimplecurses into a usable location.
This can be donw with

        make deps

or by installing bashsimplecurses system-wide.

Wi-Fi Tools
-----------

Initially, this tool is being used to develop unorthodox wi-fi monitoring tools
and a self-contained Evil Twin attack mechanism. In order to do this, it
provides some setup scripts and some tools.

### Dependency tasks

In order to build hostapd with evil twin capabilities, we need an older version
of OpenSSL. Since I don't want to deal with an older OpenSSL as a dependency,
and I don't want to install an older OpenSSL system-wide, I have elected to
build a statically linked OpenSSL and statically link OpenSSL to the
hostapd-wpe_cli binary.

  1. To build all dependencies and hostapd automatically, simply run
   "make hostapd"
  2. To build a statically linked OpenSSL, run "make openssl" which will run the
   task to build openssl-1.0.2e.
  3. Do "make hostapd-2.6" to fetch the hostapd-2.6 source.
  4. Do "make hostapd-wpe" to fetch the hostapd-wpe patch and apply it to the
   hostapd-2.6 source.
  5. Do "make hostapd-build" to build the hostapd-wpe_cli application.

### tshark tasks

Presence Monitoring: Uses management frames to measure and identify nearby
devices without them being connected to your wifi access point. To start
presence monitoring, run the command "wifiwatchdog"

Evil Twin AP: Automatically attempt to carry out Evil Twin attacks against
nearby wifi devices.

