#file: doc/cheat-sheets/mac-cheat-sheet.sh

# on the server 
sudo apt install sshfs

# on the client
brew cask install osxfuse


# how-to map network drive over ssh on the client
ssh_user=phz; domain=in.phz.fi; remote=monolith
mkdir -p ~/mnt/$remote/ ; 
sudo echo sshfs -o allow_other,defer_permissions $ssh_user@$remote.$domain/:/home/$ssh_user ~/mnt/$remote/

sudo sshfs -o allow_other,defer_permissions phz@monolith.in.phz.fi:/home/phz ~/mnt/monolith
sudo umount -f phz@monolith.in.phz.fi:/home/phz
pgrep -lf sshfs
kill -9 <pid_of_sshfs_process>

# dns resolution https://community.spiceworks.com/topic/2099557-apple-mac-hostname-changes-itself
net -n computername -W in.phz.fi -P ads dns register

# how-to get hw info - lsb_release -a for mac
system_profiler SPSoftwareDataType

# how-to check that a DNS server is working to a target url 
nslookup <<target-uri>> <<dns-server-to-check>>
nslookup www.google.fi 8.8.8.8
dig @8.8.8.8 www.apple.com

networksetup -listallnetworkservices

networksetup -setdnsservers 'Wi-Fi' \
8.8.8.8 8.8.4.4 \
10.130.130.67 10.185.51.11 10.158.51.11 10.158.51.12 10.158.55.11


# how-to list the dns servers 
networksetup -getdnsservers 'Wi-Fi'
scutil --dns
scutil --set HostName $(scutil --get LocalHostName)


# which tcp / ip ports are open
sudo lsof -PiTCP -sTCP:LISTEN

# get list of my hardware devices 
sudo networksetup -listallhardwareports

# install brew if not yet installed 
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# brew install iproute2mac
ip link show en0

# how-to check the current routes
sudo netstat -nr 

# how-to write a caron or down arrow 
# Press Ctrl + Command + Space , search for arrow , right click copy info
▼▼▼ or ↓ ↓↓↓

# how-to type a caret or up-arrow
^^^ or ↑ ↑↑↑

Déjà vu

# lo is the loopback interface
# en0 and en1 are your hardware interfaces (usually Ethernet and WiFi)
# p2p0 is a point to point link (usually VPN)
# p2p is Apple’s custom WiFi-Direct (used by things like personal hotspot in place of normal WiFi in some phases
# stf0 is a "six to four" interface (IPv6 to IPv4)
# gif01 is a software interface
# bridge0 is a software bridge between other interfaces
# utun0 is used for "Back to My Mac" - a the tunnel interface driver
# XHC20 is a USB network interface
# awdl0 is Apple Wireless Direct Link (Bluetooth) to iOS devices

subnet=192.168.0.2/16
vpn_interface=<<vpn-interface>>
vpn_server_ip=<<vpn-server-ip>>
vpn_gateway=<<vpn_gateway>>
non_vpn_gateway
/sbin/route add $subnet -interface $vpn_interface 0 $vpn_server_ip $vpn_gateway $non_vpn_gateway


# a solution for the dns resolution problem
# src: https://apple.stackexchange.com/a/63059/258419
sudo dscacheutil -flushcache;sudo killall -HUP mDNSResponder

# which are my dns servers 
grep nameserver <(scutil --dns)

Some UseFull keyboard shortcuts via the finnish mac keyboard
Go to folder from Finder: Shift + Command + G
Pipe (|) = Alt + 7
Backslash (\) = Shift + Alt + 7
Open square bracket ([) = Alt + 8
Closed square bracket (]) = Alt + 9
Open curly bracket ({) = Shift + Alt + 8
Closed curly bracket (}) = Shift + Alt + 9
Dollar sign ($) = Alt + 4
Tilde (~) = Alt + ¨

Page up = Fn + Up
Page down = Fn + Down

Print screen = Cmd + Shift + 3
Partial print screen = Cmd + Shift + 4 (You get a cursor to select what to capture)
Print window = Cmd + Shift + 4 and then press Spacebar
Shift + Right click - copy the path to a file ( needs some settings )
Delete = Fn + Backspace
Delete file from Finder = Cmd + BackspaceThe 

# how-to install java 8 
brew cask install caskroom/versions/java8 
brew install scala  
brew install sbt 

# which are the OpenDNS servers
208.67.222.222
208.67.220.220

# which are the google dns servers
8.8.8.8
8.8.4.4


# eof file: doc/cheat-sheets/mac-cheat-sheet.sh