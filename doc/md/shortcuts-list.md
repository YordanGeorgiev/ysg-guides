#  VIRTUALIZATION GUIDE


Table of Contents

  * [1. INTRODUCTION](#1-introduction)
    * [1.1. Purpose](#11-purpose)
    * [1.2. Target Setup](#12-target-setup)
    * [1.3. Master storage](#13-master-storage)
    * [1.4. Version control](#14-version-control)
  * [2. CLONE THE REPO](#2-clone-the-repo)
    * [2.1. Clone this GitHub repo as follows](#21-clone-this-github-repo-as-follows)
  * [3. INSTALLATIONS AND CONFIGURATIONS](#3-installations-and-configurations)
    * [3.1. Install Windows OS on the host](#31-install-windows-os-on-the-host)
    * [3.2. Create initial dir structure](#32-create-initial-dir-structure)
    * [3.3. Install Chrome, Firefox and Opera for Windows](#33-install-chrome,-firefox-and-opera-for-windows)
    * [3.4. Configure networking , connect to Internet](#34-configure-networking-,-connect-to-internet)
    * [3.5. Install WIN GNU binaries](#35-install-win-gnu-binaries)
    * [3.6. Install Strawberry Perl on Windows](#36-install-strawberry-perl-on-windows)
    * [3.7. Configure the WIN PATH env var](#37-configure-the-win-path-env-var)
    * [3.8. Install cygwin on Windows host](#38-install-cygwin-on-windows-host)
    * [3.9. Install cygwin packages](#39-install-cygwin-packages)
    * [3.10. Install Windows utility applications](#310-install-windows-utility-applications)
    * [3.11. Install proper text editors](#311-install-proper-text-editors)
    * [3.12. Install a password manager application](#312-install-a-password-manager-application)
    * [3.13. Install Oracle Virtual Box](#313-install-oracle-virtual-box)
    * [3.14. Install Oracle Virtual Box Extension Pack](#314-install-oracle-virtual-box-extension-pack)
    * [3.15. Enable fully read,write access to a shared folder on the host from the guest](#315-enable-fully-read,write-access-to-a-shared-folder-on-the-host-from-the-guest)
      * [3.15.1. Install the Guest Additions prerequisites](#3151-install-the-guest-additions-prerequisites)
      * [3.15.2. Install the Guest Additions](#3152-install-the-guest-additions)
      * [3.15.3. Change your for the share dir to be automounted on vm boot](#3153-change-your-for-the-share-dir-to-be-automounted-on-vm-boot)
      * [3.15.4. add yourself to the vboxsf group ](#3154-add-yourself-to-the-vboxsf-group-)
      * [3.15.5. reboot and verify](#3155-reboot-and-verify)
  * [4. MAINTENANCE AND OPERATIONS](#4-maintenance-and-operations)
    * [4.1. Start and stop vms](#41-start-and-stop-vms)
      * [4.1.1. Start a virtual machine](#411-start-a-virtual-machine)
      * [4.1.2. Stop a virtual machine](#412-stop-a-virtual-machine)
    * [4.2. VMs backup and restore](#42-vms-backup-and-restore)
      * [4.2.1. Backup a single vm](#421-backup-a-single-vm)
      * [4.2.2. Backup the current state of the virtual machines](#422-backup-the-current-state-of-the-virtual-machines)
      * [4.2.3. Restore a backup of vm](#423-restore-a-backup-of-vm)
      * [4.2.4. How-to attach an iso drive as a DVD on the ](#424-how-to-attach-an-iso-drive-as-a-dvd-on-the-)


    

## 1. INTRODUCTION


    

### 1.1. Purpose
The purpose of this guide is to provide a practical step-by-step doable from top to bottom guide for setting up a full development environment for Windows and Linux relying heavily on virtualization

    

### 1.2. Target Setup
The target setup of this guide is a physical Windows machine operating a fully configurable network of virtual machines ( guests ) which all will have access both internall to one another and to the Internet via the network connections of the host machine. 
The Guests will have also read and write access to a shared dir on the host, which will be visible as mounted share to the guests. 

    

### 1.3. Master storage
The master storage of this document is the followign mark-down file in GitHub:
https://github.com/YordanGeorgiev/you-guides/doc/md 
You could download the pdf ver

    

### 1.4. Version control
Each version of this document is identifiable via the git commit hash  - should you find an error / want to suggest a change in the content of the document - clone this github repository and create a merge request … Emails / IM's might just as well be ignored / noted but left without further action ...

    

## 2. CLONE THE REPO


    

### 2.1. Clone this GitHub repo as follows
Clone this GitHub repo as follows:

    cd ~
    git clone git://github.com/YordanGeorgiev/ysg-guides .

## 3. INSTALLATIONS AND CONFIGURATIONS


    

### 3.1. Install Windows OS on the host
If you just bought the machine, congratulation. Plug it to the wall , put it on and follow the instructions on the screen. Do not quickly press next , next , but always use the customizable options and plan a bit before configuring ( for example the keyboard layout is trully something you should feel confortable with ... )

    

### 3.2. Create initial dir structure
Now this is important. The reason for creating initial dir structure are as follows:
 - once estalished naming conventions and logic within the structure you would NEVER have to loose any important file or dir again. Period. 

    mkdir -p C:\var\<<org>>\hosts\%COMPUTERNAME%\

### 3.3. Install Chrome, Firefox and Opera for Windows
Install Chrome, Firefox and Opera for Windows or any other browsers. The principle is to have at least 3 so that you could compare the different rendering of the html pages by swithing to a different browser. 

    

### 3.4. Configure networking , connect to Internet
Configure networking , connect to Internet. 

    

### 3.5. Install WIN GNU binaries
Google download Windows GNU binaries. Download and install the following MUST-HAVE binaries: grep , less

    

### 3.6. Install Strawberry Perl on Windows
Google download Strawberry Perl for Windows. Install for your platform ( 32-bit or 64-bit)

    

### 3.7. Configure the WIN PATH env var
This step will enable to quickly run one-liners with the VBoxManage.exe to quickly change virtualization settings. 
Open the advanced system properties on Windows add the VBobxManage.exe directory into your PATH environmental variable. 
Add the path of the cygwin installer as well as it could be used from both the cygwin shell and the cmd.exe. 

    :: WinLogo + R , type:
    sysdm.cpl

### 3.8. Install cygwin on Windows host
You will use cygwin only as the terminal for your virtual machines with a very limited amount of packages. 

    

### 3.9. Install cygwin packages
Install the following cygwin packages

    for /f "tokens=*" %i in ('echo bash binutils bzip2 cygwin gcc-core gcc-g++ gcc-java gzip m4 make unzip zip') do setup-x86_64.exe -n -q -s http://cygwin.mirror.constant.com -P %i

### 3.10. Install Windows utility applications
For each step in this sub-section you could install a different application than the suggested one, however skipping the advise to install a type of application will make you work more difficult … 

    

### 3.11. Install proper text editors
Notepad is not a proper text editor - install TextPad, NotePad++, Atom or whatever else LIGHT text editor for quickly editing text and configuration files

    

### 3.12. Install a password manager application
Install a Password Manager application - in this setup we use PasswordSafe:
https://pwsafe.org/


    

### 3.13. Install Oracle Virtual Box
Google the  download oracle virtual box, which at the moment will provide you with the download page @:
https://www.virtualbox.org/wiki/Downloads
Since the target setup is to have the VB running on the Widows hosts you would choose the download the package for the Windows hosts.

    

### 3.14. Install Oracle Virtual Box Extension Pack
Google the  download oracle virtual box extension pack, which at the moment will provide you with the download page @:
https://www.virtualbox.org/wiki/Downloads
You have to double click the file and it will open with the VirtualBox UI. 

    

### 3.15. Enable fully read,write access to a shared folder on the host from the guest
This is the most error prone section, as your mealeage will vary. 
This step will enable you to access a certain root dir on your Windows host machine from the Linux guest terminal. 
In this example the name of the share from the OVB perspective will be vshare ( which is the default ) , the full dir path to the Windows OS ( the host OS ) will be "C:\var\" and the full file path to access it from the guest vm will be "/vagrant", and finally the name of the user to enable the full rea/write access will be "you". 

    # how-to add a shared folder on the host
    VBoxManage sharedfolder add "host-name" -name "vshare" -hostpath "C:\var" -automount
    
    

#### 3.15.1. Install the Guest Additions prerequisites
Install the Guest Additions prerequisites by issuing the following command:

    sudo apt-get install -y build-essential make gcc  linux-headers-$(uname -r) linux-headers-generic make linux-source  linux-generic linux-signed-generic
    

#### 3.15.2. Install the Guest Additions
Do not use the .iso file to download and the installer from there - it will simply not work

    sudo apt-get install virtualbox-guest-dkms

#### 3.15.3. Change your for the share dir to be automounted on vm boot
Change your for the share dir to be automounted on vm boot by addding the folowing lines to the end of your fstab file

    #/media/sf_vshare /vagrant bind defaults,bind 0 0
    /media/sf_vshare /vagrant vboxsf bind,uid=10001,rw,umask=0000 0 0
    
    # eof file: /etc/fstab

#### 3.15.4. add yourself to the vboxsf group 
You need to add yourself to the vboxsf group in order to be able to edit as non-root from your vm the files on your host machine. 

    # run the fooll
    sudo mount -a
    
    sudo usermod -G vboxsf -a you

#### 3.15.5. reboot and verify
Reboot the vm and login via ssh to verify the file sharing. 

    # ssh to the vm
    ssh you@host-name
    
    # check as yourself that you have 
    find /vagrant

## 4. MAINTENANCE AND OPERATIONS
This section contains maintenance and operational activities around the virtualization. 

    

### 4.1. Start and stop vms


    

#### 4.1.1. Start a virtual machine
To start a virtual machine perform the following command from the Start , Run dialog box. 

    vm-start host-name

#### 4.1.2. Stop a virtual machine
To stop a virtual machine perform the following command from the Start , Run dialog box. 

    vm-stop host-name

### 4.2. VMs backup and restore


    

#### 4.2.1. Backup a single vm
To backup a single vm issue the following command:

    # list first you vms 
    VBoxManage list vms
    
    # select the host-name vm
    VBoxManage export host-name -o host-name.ova

#### 4.2.2. Backup the current state of the virtual machines
If you performed the installations and configurations as described above you will be able to backup any or all of your guests by simply backing up the vms folder. 

    # in bash how-to export all myy Virtual box vms in Windows in the current dir
    while read -r vms ; do echo VBoxManage export "$vms" -o "$vms".ova ; done < <(VBoxManage list vms|cut -d'"' -f2)

#### 4.2.3. Restore a backup of vm
Copy the backed-up folder into your Windows hosts vms folder. 
Open OVB. Machine add , navigate to the just copied &lt;&lt;machine-name&gt;&gt;.ova. 

    

#### 4.2.4. How-to attach an iso drive as a DVD on the 
To attach the storage would mean in the physical world to buy a DVD drive and physically attach it to the hardware of your box. 
Issue the following 2 commands:

    # add the ide 
    VBoxManage.exe storagectl "host-name" --name IDE --add ide
    
    # attach the DVD drive with the following command
    VBoxManage.exe storageattach "host-name" --storagectl IDE --port 0 --device 0 --type dvddrive --medium "C:\var\pckgs\oracle\virtual-box\VBoxGuestAdditions_5.1.2.iso"

