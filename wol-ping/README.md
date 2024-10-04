# wol-ping.sh

This bash script is for waking up server with wakeonlan utility.
Script needs .env file in same location it is run with server's
IP address and MAC address variables to work as shown below.

SERVER="xxx.xxx.xxx.xxx"
WAKEONLAN_MAC="xx:xx:xx:xx:xx:xx"

Script checks if wakeonlan utility is installed and installs it if not.
After this wakeonlan command is issued and script pings server until it
has waken up. Script exits when server starts responding and reports time
it took server to wake up. Script includes current system time printed when
server is still waking up.

Tested with Ubuntu 22.04.5 LTS workstation.
