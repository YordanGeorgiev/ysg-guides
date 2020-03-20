#  VIRTUALIZATION GUIDE


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
    * [3.12. Install Oracle VirtualBox](#313-install-oracle-virtualbox)
    * [3.13. Install Oracle VirtualBox Extension Pack](#314-install-oracle-virtualbox-extension-pack)
    * [3.14. Enable fully read/write access to a shared folder on the Host from the Guest](#315-enable-fully-read-write-access-to-a-shared-folder-on-the-host-from-the-guest)
      * [3.14.1. Install the Guest Additions prerequisites](#3151-install-the-guest-additions-prerequisites)
      * [3.14.2. Install the Guest Additions](#3152-install-the-guest-additions)
      * [3.14.3. Change your shared directory to be automounted on VM boot](#3153-change-your-for-the-shared-directory-to-be-automounted-on-vm-boot)
      * [3.14.4. Add yourself to the vboxsf group](#3154-add-yourself-to-the-vboxsf-group)
      * [3.14.5. Reboot and verify](#3155-reboot-and-verify)
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
The purpose of this guide is to provide a practical step-by-step doable from top to bottom guide for setting up a full development environment for Windows and Linux relying heavily on virtualization.

    

### 1.2. Target setup
The target setup of this guide is a physical Windows machine operating a fully configurable network of virtual machines (Guests), which all will have access both internal to one another and to the Internet via the network connections of the Host machine. 
The Guests will have also read and write access to a shared directory on the Host, which will be visible as mounted share to the Guests. 

    

### 1.3. Master storage
The master storage of this document is the following Markdown file in GitHub:
https://github.com/YordanGeorgiev/you-guides/doc/md 
You could also download the pdf version.

    

### 1.4. Version control
Each version of this document is identifiable via the git commit hash  - should you find an error / want to suggest a change in the content of the document - clone this github repository and create a merge request. Emails / IM's might just as well be ignored / noted but left without further action.

    

## 2. CLONE THE REPO


    

### 2.1. Clone this GitHub repo as follows
You may clone this GitHub repo as follows, if you have Git already installed:

```
cd ~
git clone git://github.com/YordanGeorgiev/ysg-guides
```

## 3. INSTALLATIONS AND CONFIGURATIONS


    

### 3.1. Install Windows OS on the Host
If you just bought the machine, congratulations. Plug it to the socket, turn it on and follow the instructions on the screen. Do not quickly press Next, Next, but always use the customizable options and plan a bit before configuring. For example, the keyboard layout is trully something you should feel confortable with.

    

### 3.2. Create initial directory structure
This is important. The reason for creating initial dir structure are as follows:
 - once estalished naming conventions and logic within the structure you would NEVER have to loose any important file or dir again. Period. 

```
mkdir -p C:\var\<<org>>\hosts\%COMPUTERNAME%\
```

### 3.3. Install Chrome, Firefox and Opera for Windows
Install Chrome, Firefox and Opera for Windows or any other browsers. The principle is to have at least 3 so that you could compare the different rendering of the html pages by swithing to a different browser. 

    

### 3.4. Configure network, connect to the Internet
Configure network, connect to the Internet.

    

### 3.5. Install GnuWin binaries
Google download GnuWin Packages. Download and install the following MUST-HAVE binaries: grep, less

    

### 3.6. Install Strawberry Perl on Windows
Google download Strawberry Perl for Windows. Install for your platform (32-bit or 64-bit)

    

### 3.7. Configure the Windows PATH environment variable
This step will enable to run one-liners with VBoxManage.exe to quickly change virtualization settings. 
Open the advanced system properties on Windows (sysdm.cpl), add the VBobxManage.exe directory into your PATH environmental variable. 
Add the path of the cygwin installer as well, so that it can be used from both the cygwin shell and the cmd.exe. 

```
# Press Win+R on the keyboard, execute this command:
sysdm.cpl
```

### 3.8. Install cygwin on Windows Host
You will use cygwin only as the terminal for your virtual machines with a very limited amount of packages. 

    

### 3.9. Install cygwin packages
Install the following cygwin packages

```
for /f "tokens=*" %i in ('echo bash binutils bzip2 cygwin gcc-core gcc-g++ gcc-java gzip m4 make unzip zip') do setup-x86_64.exe -n -q -s http://cygwin.mirror.constant.com -P %i
```

### 3.10. Install Windows utility applications
For each step in this subsection you could install a different application than the suggested one, however skipping the advice to install a type of application will make your work more difficult.

    

### 3.11. Install proper text editors
Notepad is not a proper text editor - install TextPad, NotePad++, Atom or whatever else LIGHT text editor for quickly editing text and configuration files

    

### 3.12. Install Oracle VirtualBox
Google download Oracle VirtualBox, which at the moment will lead you to the download page at:
https://www.virtualbox.org/wiki/Downloads
Since the target setup is to have the VirtualBox running on the Widows Host, you would choose the download the package for Windows.

    

### 3.13. Install Oracle VirtualBox Extension Pack
Google download Oracle VirtualBox extension pack, which at the moment will lead you to the download page at:
https://www.virtualbox.org/wiki/Downloads
You have to double-click the file and it will open with the VirtualBox UI. 

    

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
