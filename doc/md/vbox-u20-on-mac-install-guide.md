#  VIRTUAL BOX SETUP FOR UBUNTU 20.04.02 GUEST ON A MAC HOST
* [1. INTRODUCTION](#1-introduction)
  * [1.1. PURPOSE](#11-purpose)
  * [1.2. AUDIENCE](#12-audience)
* [2. INSTALLATION](#2-installation)
  * [2.1. INSTALL THE LATEST VERSION FOR VIRTUALBOX FOR MAC](#21-install-the-latest-version-for-virtualbox-for-mac)
  * [2.2. DOWNLOAD THE ISO IMAGE](#22-download-the-iso-image)
  * [2.3. CREATE A NEW VM IN THE VIRTUALBOX UI](#23-create-a-new-vm-in-the-virtualbox-ui)
  * [2.4. SET THE NETWORK SETTINGS OF THE VM](#24-set-the-network-settings-of-the-vm)
  * [2.5. INSERT THE ISO IMAGE IN THE VIRTUAL MACHINES CD-ROM DRIVE](#25-insert-the-iso-image-in-the-virtual-machines-cd-rom-drive)
  * [2.6. OPEN THE UI AND INSTALL THE ABSOLUTE MINIMUM PREREQUISITE BINARIES](#26-open-the-ui-and-install-the-absolute-minimum-prerequisite-binaries)
* [3. INSTALL THE UBUNTU OS](#3-install-the-ubuntu-os)
  * [3.1. CHECK THE IP OF THE GUEST AND SSH TO IT](#31-check-the-ip-of-the-guest-and-ssh-to-it)
  * [3.2. SSH TO THE BOX FROM THE MAC TERMINAL ](#32-ssh-to-the-box-from-the-mac-terminal-)
  * [3.3. INITIAL MINIMALISTIC SHELL SETUP (OPTIONAL)](#33-initial-minimalistic-shell-setup-(optional))
* [4. SETUP FILE SHARING](#4-setup-file-sharing)
  * [4.1. INSERT GUEST ADDITIONS CD IMAGE](#41-insert-guest-additions-cd-image)
    * [4.1.1. Mount the CDROM and run the installer](#411-mount-the-cdrom-and-run-the-installer)
    * [4.1.2. Add the shared folder on the mac](#412-add-the-shared-folder-on-the-mac)
    * [4.1.3. Enable symlinking in the shared folder](#413-enable-symlinking-in-the-shared-folder)
    * [4.1.4. In case the shared folder does not show up](#414-in-case-the-shared-folder-does-not-show-up)
    * [4.1.5. Configure the fstab file ](#415-configure-the-fstab-file-)
    * [4.1.6. Add the ubuntu user to the vboxsf group (optional)](#416-add-the-ubuntu-user-to-the-vboxsf-group-(optional))
    * [4.1.7. Add a static IP to your guest ](#417-add-a-static-ip-to-your-guest-)
    * [4.1.8. Disable ipv6](#418-disable-ipv6)




    

## 1. INTRODUCTION


    

### 1.1. Purpose
The purpose of this guide is to provide you the initial vm setup on a mac host running VirtualBox guest machine with the Ubuntu 20.04.02 OS.

    

### 1.2. Audience
Technical personnel ...

    

## 2. INSTALLATION


    

### 2.1. Install the latest version for VirtualBox for MAC
Go to the following page: https://www.virtualbox.org/wiki/Downloads
Click on the OS X hosts link https://download.virtualbox.org/virtualbox/6.1.18/VirtualBox-6.1.18-142142-OSX.dmg

    

### 2.2. Download the iso image
Open the following page: 
https://cdimage.ubuntu.com/ubuntu-server/focal/daily-live/current/

Download the iso file from the following link
https://cdimage.ubuntu.com/ubuntu-server/focal/daily-live/current/focal-live-server-amd64.iso

    

### 2.3. Create a new VM in the VirtualBox UI
Open the IU of the VirtualBox Application on your mac host.
From the Menu choose Machine - New.
For name of the machine type "sat" ( without the quotes, sat means the satellite-host ;o). 
For the "Machine Folder" choose /Users/&lt;&lt;your-mac-user-name&gt;&gt;/vms ( In my case /Users/ysg/vms)
For the Type choose "Linux"
For the Version Choose "Ubuntu 64-bit"
Click on Continue. 
Set at least the half of your mac's host physical amount of RAM. Click continue.
Choose "Create virtual hard-disk now". Click continue.
Choose "VDI" type. Click continue.
Choose "dynamically allocated". Click continue.
Set at least 20GB of hard-disk space.


### 2.4. Configure the Guest System Settings
On the mac's VirtualBox UI click on the sat machine, click on the Settings icon. Click on the System icon.
On the motherboard tab, in the Boot order remove the floppy drive. 
On the Processor tab, set at least 2 processors, Check the "Enable PAE/NX", check the "Enable Nested VT/AMD-V"
On the Display Icon of the top , click the Screen tab, select 1 monitor, set at least 90% of your phyiscal memory 
as the the video memory, Check the "Enable 3D acceleration" checkbox too.


### 2.5. Create a local-host network in VirtualBox
On the mac's VirtualBox UI menu click on File - Host Network Manager.
Click on the reate network icon ( the one with a plus) and accept the default values, which are as follows: 
Ensure the DHCP Server checkbox on the top right is NOT checked.
Click on the network, Click on the properties icon. Click on the Adapter tab bellow.
Option for "Configure Adapter Manually" is checked. 
For the "IPV4 Address" use the "192.168.56.1" value
For the "IPV4 Network Mask" use the "255.255.255.0" value. 
Leave the IPV6 Address empty.
Set the "0" value for the "IPV6 Prefix Length:"
Click on the Apply button to apply those settings, click on the Close button to close the properties dialog.



### 2.4. Set the Network Settings for the guest vm
On the mac's VirtualBox UI click on the new machine on the left and click the Settings button.
Click on the Network icon.
For Adapter 1. 
Ensure the "Enable Network Adapater" checkbox is checked. 
Change the "Attached to" to "NAT Network". Accept 
Click on the Adapater 2 tab.
Select the "Enable Network Adapter" checkbox.
Choose the "Attached to" "Host-only Adapater option from the Dropdown.
Ensure the vboxnet0 localhost network you created ( or accepted ) in the previous step is chosen.
Click Ok to close the machine Preferences dialog box.


### 2.5. Insert the ISO image in the virtual machines CD-Rom drive
On the mac's VirtualBox UI, chose the sat box, Settings, Storage , Empty , Optical Drive , choose the downloaded image: focal-desktop-image.iso. Close the dialog box.

    

## 3. Install the Ubuntu OS
On MAC host VB UI click on the left on the machine and click the start button on the top. 
Ensure the iso image selected from the previous step is the one chosen in the dropdown to load boot the machine with this iso image. 
Once the machine starts booting, from the VirtualBox UI , choose View - Scaled Mode to be able to resize the vm window to be larger. Press the "Switch" button if asked to approve the switch to the Scaled Mode.

### 3.1. Choose the regional OS settings of the guest
On the installation wizard screen on the guest select the following: 
 - English as the language
 - Your keyboard layout as the keyboard layout 
 - Click "Done"


### 3.2. Accept the suggested network settings
Accept the suggested network settings on the next screen. Cick "Done".


### 3.2. Avoid adding proxy address, unless you know what you are doing
If you are behind a corporate firewall and you feel confortable with addig a proxy server, do it now, otherwise leave it empty.
Click on Done

### 3.3. Accept the proposed site mirror for download
Unless you really know a better site do download from ... Click "Done".
    

### 3.4. Accept the proposed "Guided Storage configuration"
Click "done", "done" and "continue".
    
### 3.5. Conigure the sudoer OS user
In order to have as similar as possible setup as the one on an Ubuntu 20 server running in aws set the following:
"Your name" , set "ubuntu" ( without the quotes)
"Your server's name, set "sat"  ( without the quotes)
"Pick an username" , set "ubuntu" ( without the quotes)
Type a password and confirm it.
Click on "done".

### 3.6. Install OpenSSH server , import GitHub identities
Check the "Install OpenSSH server. 
Optionally you could import your GitHub identities public files. 
Do check the "enable password authentication over ssh.
Click on Done. 

### 3.6. Reboot after install
When the "Reboot now" appears at the bottom of the screen , cycle with the tab and hit enter on top of it
When prompted to remove the boot media, Hit enter. The machine will restart , a lot of boot order text appear after 1 min when the flashing of the boot messages has ended hit Enter - you should see the "sat login" prompt.


## 4. Provision Ubuntu OS
Once the screen is cleared and you get the "sat login" prompt. For user type "ubuntu" for password type the one you set in the previous step.

### 4.1. Install the absolute minimum prerequisite binaries
To be able able to access the vm via ssh you would need to install open-ssh server. To be able to edit any files on the host you would need to install a text editor - vim. 
    # install the minimun required binaries    
    sudo apt-get install -y vim net-tools git zip unzip build-essential linux-headers-$(uname -r) perl make



### 4.2. Check the IP of the guest and ssh to it
Login with the ubuntu user and type the ubuntu password you set during the installation.

    
    # on the ubuntu get the ip of the host-only adapater using network
    for i in {1..9}; do sudo ifconfig -a | grep -i -A 1 enp0s$i | grep -i inet | awk '{print $2}'; done

    # the one IP address which starts with 192.168.56 is the ip address of the guest




### 4.3. Ssh to the box from the mac terminal 
Open the iterm terminal app in your mac host. 

    ssh ubuntu@192.168.56.13 # your ip will probably be something else ...
    # you would have to type "yes" when whether or not to connect to the host



### 4.4 Enable passwordless sudo execution 
Run the following oneliner to avoid having to type your ubuntu password everytime. 
This is part of the setup !!! Not doing this step will certainly prevent provisioning steps from correct execution.

    # add yourself to the sudoers group, to avoid typing passwords 
    test $(grep `whoami` /etc/sudoers|wc -l) -ne 1 && echo $(whoami)' ALL=(ALL) NOPASSWD: ALL'|sudo tee -a /etc/sudoers


## 5. SETUP FILE SHARING
    

### 4.1. Insert Guest Additions CD Image
Select the sat VirtualBox Window having the command prompt on the sat guest. From the UI menu of the Virtual Box 
select "Devices" , select "Insert Guest Additions CD Image...". 



#### 4.2. Mount the CDROM and run the installer
Open the Iterm terminal

    # mount the cdrom
    sudo mkdir -p /mnt/cdrom ; sudo mount /dev/sr0 /mnt/cdrom
    # you should see the msg on the next line:
    # mount: /mnt/cdrom: WARNING: device write-protected, mounted read-only.
    
    
    # run the installer 
     cd /mnt/cdrom ;sudo sh VBoxLinuxAdditions.run
     Cycle through the prompts and once you finish installing, let it reboot
    
  
#### 4.3. Add the shared folder on the mac
In the mac terminal issue the following command

    # shutdown the vm 
    VBoxManage controlvm "sat" poweroff
    
    # add a share folder 
    VBoxManage sharedfolder add "sat" --name hos --hostpath "/Users/$USER" --automount --auto-mount-point=/hos

#### 4.4. Enable symlinking in the shared folder
Many of the installations scripts and node modules do use symlinkin, which will fail if you do not have the following cmd on the mac.

    # sat is the vm name , hos is the shared folder name
    VBoxManage setextradata "sat" VBoxInternal2/SharedFoldersEnableSymlinksCreate/hos 1
    
    # start the vm 
    VBoxManage startvm "sat" --type headless

#### 4.5. In case the shared folder does not show up
Run the following command in the guest's terminal.

    # add the ubuntu user to the vboxsf OS group
    sudo usermod -a -G vboxsf ubuntu

    # and verify by 
    sudo cat /etc/group| grep -i vboxsf
    # you should see the next line
    # vboxsf:x:998:ubuntu

    sudo mount -t vboxsf hos -o rw,dmode=777,gid=1000,uid=1000 /hos/
    # verify that you can list all the files from your host's home dir by: 
    find /hos/

#### 4.6. Configure the fstab file 
In order to have the file sharing between the host and the guest permanently you must edit your fstab file on the guest as follows ( just copy paste the code snippet).

    cat << EOF | sudo tee -a /etc/fstab
    
    # <file system> <mount point>   <type>  <options>       <dump>  <pass>
    # hos /hos vboxsf bind,uid=1000,gid=1000,rw,umask=0000 0 0
    hos /hos vboxsf rw,dmode=777,gid=1000,uid=1000,umask=0022
    
    # eof file: /etc/fstab
    EOF
    
    sudo mount -a 

#### 4.7. Ensure the file sharing between the guest and the host works 
Stop the guest from the mac terminal 

    # on the mac terminal ( obs if you are on the guest you would have to exit)
     VBoxManage controlvm "sat" poweroff

    # start the guest on the mac terminal
    VBoxManage startvm "sat" --type headless
    
    # ssh to the guest once again 
    ssh ubuntu@192.168.56.15

    # check the permissions of the shared dir
    ls -la /hos/

    # the ownership of the OS user and group of the files MUST belong to the ubuntu and NOT the root

#### 4.7. Add the symlinks  
For quicker share of ssh and aws settings between the host and the guest issue the following commands: 

    cat ~/.ssh/authorized_keys >> /hos/.ssh/authorized_keys
    test -d ~/.ssh && rm -rv ~/.ssh
    for path in `echo '.aws' '.ssh'` ; do ln -sfn /hos/$path ~/$path ; done ;
    for path in `echo 'opt' 'var'` ; do ln -sfn /hos/$path ~/$path ; done ;


#### 4.8. Add a static IP to your guest 
Src doc for this step : https://www.wpdiaries.com/virtualbox-for-web-development/#static-ip-for-bridged-adapter
With the setup till now each time you reboot you will get a new IP address which makes the usage of the bash_history on your host to access the host impossible ... 
To fix that we need to setup a permanent IP address on the guest so that you could access it via a single non-changing ssh command from the host.
Now the exact IP values will depend on the IP address allocation you have access to from your IP provider - so your mileage will vary ...

    # on the guest backup the netplan file 
    sudo cp -v /etc/netplan/00-installer-config.yaml /etc/netplan/00-installer-config.yaml.`date "+%Y%m%d_%H%M%S"`.bak

    # replace the enp0s3 addresses with the one you got from the "sudo ipconfig getifaddr en0"
    # configure the permanent IP address
    cat <<EOF|sudo tee /etc/netplan/00-installer-config.yaml
    network:
      ethernets:
        enp0s3:
          dhcp4: true
        enp0s8:
          dhcp4: false
          addresses: [192.168.56.2/24]  
      version: 2
    EOF

    # and apply the conf
    sudo netplan apply
    # the guest might freeze - in any case reboot it
    
    # on the mac host add the following line to the /etc/hosts file 
    192.168.56.2      sat
    
    # now you should be able to access the guest from the host by : 
    ssh -i ~/.ssh/id_rsa.my-identity-file -v -p 22 ubuntu@sat
    # OR if you have already closed the 22 port and changed it to 5522 
    ssh -i ~/.ssh/id_rsa.my-identity-file -v -p 5522 ubuntu@sat

#### 4.1.8. Disable ipv6
To disable ipv6 perform the following change in the sysctl.conf file:

    # to disable ip6 
    cat <<EOF | sudo tee -a /etc/sysctl.conf > /dev/null 
    net.ipv6.conf.all.disable_ipv6 = 1
    net.ipv6.conf.default.disable_ipv6 = 1
    net.ipv6.conf.lo.disable_ipv6 = 1
    EOF

    # apply 
    sudo sysctl -p

    # and verify 
    wget -6 www.google.com

