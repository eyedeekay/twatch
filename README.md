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

### tshark tasks

Presence Monitoring: Uses management frames to measure and identify nearby
devices without them being connected to your wifi access point.

Evil Twin AP: Automatically attempt to carry out Evil Twin attacks against
nearby wifi devices.

