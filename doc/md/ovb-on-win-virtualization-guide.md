#  VIRTUALIZATION GUIDE FOR WINDOWS


Table of Contents

  * [1. INTRODUCTION](#1-introduction)
    * [1.1. Purpose](#11-purpose)
    * [1.2. Target setup](#12-target-setup)
    * [1.3. Master storage](#13-master-storage)
    * [1.4. Version control](#14-version-control)
  * [2. CLONE THE REPO](#2-clone-the-repo)
    * [2.1. Clone this GitHub repo as follows](#21-clone-this-github-repo-as-follows)
  * [3. INSTALLATIONS AND CONFIGURATIONS](#3-installations-and-configurations)
    * [3.1. Install Windows OS on the Host](#31-install-windows-os-on-the-host)
    * [3.2. Create initial directory structure](#32-create-initial-directory-structure)
    * [3.3. Install Chrome, Firefox, and Opera for Windows](#33-install-chrome-firefox-and-opera-for-windows)
    * [3.4. Configure network, connect to the Internet](#34-configure-network-connect-to-the-internet)
    * [3.5. Install GnuWin binaries](#35-install-gnuwin-binaries)
    * [3.6. Install Strawberry Perl on Windows](#36-install-strawberry-perl-on-windows)
    * [3.7. Configure the Window PATH environment variable](#37-configure-the-windows-path-environment-variable)
    * [3.8. Install cygwin on Windows Host](#38-install-cygwin-on-windows-Host)
    * [3.9. Install cygwin packages](#39-install-cygwin-packages)
    * [3.10. Install Windows utility applications](#310-install-windows-utility-applications)
    * [3.11. Install proper text editors](#311-install-proper-text-editors)
    * [3.12. Install Oracle VirtualBox](#312-install-oracle-virtualbox)
    * [3.13. Install Oracle VirtualBox Extension Pack](#313-install-oracle-virtualbox-extension-pack)
    * [3.14. Enable fully read/write access to a shared folder on the Host from the Guest](#314-enable-fully-read-write-access-to-a-shared-folder-on-the-host-from-the-guest)
      * [3.14.1. Install the Guest Additions prerequisites](#3141-install-the-guest-additions-prerequisites)
      * [3.14.2. Install the Guest Additions](#3142-install-the-guest-additions)
      * [3.14.3. Change your shared directory to be automounted on VM boot](#3143-change-your-for-the-shared-directory-to-be-automounted-on-vm-boot)
      * [3.14.4. Add yourself to the vboxsf group](#3144-add-yourself-to-the-vboxsf-group)
      * [3.14.5. Reboot and verify](#3145-reboot-and-verify)
  * [4. MAINTENANCE AND OPERATIONS](#4-maintenance-and-operations)
    * [4.1. Start and stop VMs](#41-start-and-stop-vms)
      * [4.1.1. Start a virtual machine](#411-start-a-virtual-machine)
      * [4.1.2. Stop a virtual machine](#412-stop-a-virtual-machine)
    * [4.2. VMs backup and restore](#42-vms-backup-and-restore)
      * [4.2.1. Backup a single virtual machine](#421-backup-a-single-virtual-machine)
      * [4.2.2. Backup the current state of the virtual machines](#422-backup-the-current-state-of-the-virtual-machines)
      * [4.2.3. Restore a backup of virtual machine](#423-restore-a-backup-of-virtual-machine)
      * [4.2.4. How-to attach an iso drive as a DVD on the fly](#424-how-to-attach-an-iso-drive-as-a-dvd-on-the-fly)


    

## 1. INTRODUCTION


    

### 1.1. Purpose
The purpose of this guide is to provide step-by-step instructions for setting up a QTO development environment relying heavily on virtualization in Windows. There is also a pdf version available at https://github.com/YordanGeorgiev/ysg-guides/blob/master/doc/pdf/ovb-on-win-virtualization-guide.pdf

    

### 1.2. Target setup
The target setup of this guide is a physical Windows machine (Host) operating a configurable virtual machine (Guest), which both have access to one another and to the Internet via the network connections of the Host machine. 
The Guest will also have read and write access to a shared directory on the Host. 
    

### 1.3. Submitting suggestions
Should you find an error or want to suggest a change in the content of the document, clone this github repository and create a merge request.



## 2. PREPARATION AND CONFIGURATION

This guide assumes that you have 64-bit Windows already installed on the Host, the computer is connected to the Internet and you installed a browser, for example, Firefox, Opera or Chrome. If you have 32-bit Windows, then use the appropriate 32-bit installers instead during this installation.

It is recommended to get NotePad++, TextPad, Atom or whatever else light text editor for quickly editing text and configuration files in the future.
https://notepad-plus-plus.org/downloads/


### 2.1. Install Strawberry Perl
Perl binaries, compiler (gcc) and related tools will be needed for proper deployment of QTO. Install a recommended version of Strawberry Perl from the official website to your Windows Host system:
http://strawberryperl.com/

### 2.2. Install Cygwin
Cygwin will be the main terminal for working with the virtual machine. It also comes with a bunch of packages that will be necessary for the QTO installation. Install it by downloading setup-x86_64.exe from this website:
https://cygwin.com/

During the setup choose any mirror website, keep the default packages and make sure that the following Cygwin packages get installed, too:

```
echo bash binutils bzip2 cygwin gcc-core gcc-g++ git grep gzip jq less m4 make unzip zip
```

It is possible to start the setup via a command line (Win+R, cmd, Enter) by navigating to the folder, where you downloaded setup-x86_64.exe, and executing this one-liner:
```
for /f "tokens=*" %i in ('echo bash binutils bzip2 cygwin gcc-core gcc-g++ git grep gzip jq less m4 make unzip zip') do setup-x86_64.exe -n -q -s http://cygwin.mirror.constant.com -P %i
```

### 2.3. Install VirtualBox
Install VirtualBox from this website by choosing "VirtualBox platform packages" -> "Windows hosts":
https://www.virtualbox.org/wiki/Downloads

Then download and install "VirtualBox Oracle VM VirtualBox Extension Pack".

### 2.4. Install Vagrant
Vagrant will be used together with VirtualBox to create a configured Guest virtual machine, where QTO will be run. Install Vagrant for Windows:
https://www.vagrantup.com/downloads.html

### 2.5. Configure the Windows PATH environment variable
This step will enable to run one-liners with VBoxManage.exe to quickly change virtualization settings. It is also required for working with Cygwin.

Open the Advanced System Properties on Windows (Win+R, sysdm.cpl, Enter), switch to the Advanced tab, then click on Environment Variables button.
```
sysdm.cpl
```

Scroll down and select the variable "Path" under the "System variables" and click on the "Edit" button. Add directory of VBobxManage.exe to the line and click OK.

Add the path of the Cygwin bin folder as well, so that Cygwin can be launched from the command line. 

## 3. DEPLOY VAGRANT VM

### 3.15. Enable fully read/write access to a shared folder on the Host from the Guest
This is the most error prone section, as your mileage will vary. 
This step will enable you to access a certain root directory on your Windows Host machine from the Linux Guest terminal. 
In this example the name of the share from the OVB perspective will be vshare (which is the default), the full directory path to the Windows OS (the Host OS) will be "C:\var\" and the full file path to access it from the Guest VM will be "/vagrant", and finally the name of the user to enable the full read/write access will be "user-name". 

```
# how-to add a shared folder on the Host
VBoxManage sharedfolder add "Host-name" -name "vshare" -hostpath "C:\var" -automount
```
    
    

#### 3.14.1. Install the Guest Additions prerequisites
Install the Guest Additions prerequisites by issuing the following command:

```
sudo apt-get install -y build-essential make gcc linux-headers-$(uname -r) linux-headers-generic make linux-source linux-generic linux-signed-generic
```
    

#### 3.14.2. Install the Guest Additions
Do not use the .iso file to download and the installer from there - it will simply not work

```
sudo apt-get install virtualbox-guest-dkms
```

#### 3.14.3. Change your shared directory to be automounted on VM boot
Change your shared directory to be automounted on VM boot by addding the folowing lines to the end of your fstab file. Alternatively, you can configure it in VirtualBox image Settings, Shared Folders tab. 

```
#/media/sf_vshare /vagrant bind defaults,bind 0 0
/media/sf_vshare /vagrant vboxsf bind,uid=10001,rw,umask=0000 0 0

# eof file: /etc/fstab
```

#### 3.14.4. Add yourself to the vboxsf group
You need to add yourself to the vboxsf group in order to be able to edit as non-root from your VM the files on your Host machine. 

```
# remount /etc/fstab without rebooting
sudo mount -a
    
sudo usermod -G vboxsf -a user-name
```

#### 3.14.5. Reboot and verify
Reboot the VM and login via SSH to verify the file sharing. You may need to install open-ssh server on the Guest system and set Port forwarding from 127.0.0.1 port 2522 to 10.0.2.15 port 22 in VirtualBox image preferences, Network, Advanced, Port forwarding in order to connect via SSH.

In Terminal on Guest
```
sudo apt install openssh-server
```

In bash shell on Host
```
# ssh to the VM
ssh user-name@localhost -p 2522

# check as yourself that you have 
find /vagrant
```

## 4. MAINTENANCE AND OPERATIONS
This section contains maintenance and operational activities around the virtualization. 

    

### 4.1. Start and stop VMs


    

#### 4.1.1. Start a virtual machine
To start a virtual machine navigate to the folder 'ysg-guides\src\cmd\' and execute the following cmd file with the name of the Guest system as a parameter. 

```
vm-start Guest-name
```

#### 4.1.2. Stop a virtual machine
To stop a virtual machine navigate to the folder 'ysg-guides\src\cmd\' and execute the following cmd file with the name of the Guest system as a parameter. 

```
vm-stop Guest-name
```

### 4.2. VMs backup and restore


    

#### 4.2.1. Backup a single virtual machine
To backup a single VM issue the following command:

```
# list first you VMs 
VBoxManage list vms

# select the Host-name VM
VBoxManage export Guest-name -o Guest-name.ova
```

#### 4.2.2. Backup the current state of the virtual machines
If you performed the installations and configurations as described above you will be able to backup any or all of your Guests by simply backing up the VMs folder.

```
# execute this in bash shell to export all VirtualBox VMs in Windows into the current directory
while read -r vms ; do echo VBoxManage export "$vms" -o "$vms".ova ; done < <(VBoxManage list vms|cut -d'"' -f2)
```

#### 4.2.3. Restore a backup of virtual machine
Copy the backed-up folder into your Windows Hosts virtual machines folder. 
Open OVB. Machine add, navigate to the just copied &lt;&lt;machine-name&gt;&gt;.ova. 

    

#### 4.2.4. How to attach an ISO drive as a DVD on the fly
To attach the storage would mean in the physical world to buy a DVD drive and physically attach it to the hardware of your box. 
Issue the following two commands:

```
# add the IDE 
VBoxManage.exe storagectl "Guest-name" --name IDE --add ide

# attach the DVD drive with the following command
VBoxManage.exe storageattach "Guest-name" --storagectl IDE --port 0 --device 0 --type dvddrive --medium "C:\var\pckgs\oracle\virtual-box\VBoxGuestAdditions_6.1.4.iso"
```
