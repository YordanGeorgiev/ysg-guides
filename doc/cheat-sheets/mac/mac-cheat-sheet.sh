#file: doc/cheat-sheets/mac-cheat-sheet.sh


# how-to get hw info
system_profiler SPSoftwareDataType

# which tcp / ip ports are open
sudo lsof -PiTCP -sTCP:LISTEN


 # do I have cmd firewall tool 
 which pfctl

# edit its configuration file
vim  /etc/pf.conf

# add the following lines 
# Open port 8080 for TCP on all interfaces
pass in proto tcp from any to any port 8080

# load the fw rules
sudo pfctl -f /etc/pf.conf

# list the rules
sudo pfctl -sr

Chrome
Select the address field
Command + L

# a solution for the dns resolution problem
https://apple.stackexchange.com/a/63059/258419



15. UseFull keyboard shortcuts via the finnish mac keyboard
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

Delete = Fn + Backspace
Delete file from Finder = Cmd + BackspaceThe 



# install java 8 
brew cask install caskroom/versions/java8 
brew install scala  
brew install sbt 




# eof file: doc/cheat-sheets/mac-cheat-sheet.sh
