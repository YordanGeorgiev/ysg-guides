#  VIRTUALIZATION GUIDE FOR WINDOWS


Table of Contents

  * [1. INTRODUCTION](#1-introduction)
    * [1.1 Purpose](#11-purpose)
    * [1.2 Target setup](#12-target-setup)
    * [1.3 Submitting suggestions](#13-submitting-suggestions)
  * [2. PREPARATION AND CONFIGURATION](#2-preparation-and-configuration)
    * [2.1 Install Strawberry Perl](#21-install-strawberry-perl)
    * [2.2 Install Cygwin](#22-install-cygwin)
    * [2.3 Install VirtualBox](#23-install-virtualbox)
    * [2.4 Install Vagrant](#24-install-vagrant)
    * [2.5 Configure Windows PATH variable](#25-configure-windows-path-variable)
  * [3. VIRTUAL MACHINE DEPLOYMENT](#3-virtual-machine-deployment)
    * [3.1 Clone Github repository](#31-clone-github-repository)
    * [3.2 Run deployment script](#32-run-deployment-script)
    * [3.3 Enable fully read/write access to a shared folder on the Host from the Guest](#33-enable-fully-read-write-access-to-a-shared-folder-on-the-host-from-the-guest)
    * [3.4 SSH to Guest](#34-ssh-to-guest)
    * [3.5 Install the Guest Additions prerequisites](#35-install-the-guest-additions-prerequisites)
    * [3.6 Install VirtualBox Guest Additions](#36-install-virtualbox-guest-additions)
    * [3.7 Add yourself to the vboxsf group](#37-add-yourself-to-the-vboxsf-group)
    * [3.8 Reboot and verify](#38-reboot-and-verify)
  * [4. MAINTENANCE AND OPERATIONS](#4-maintenance-and-operations)
    * [4.1 Start and stop VMs](#41-start-and-stop-vms)
    * [4.2 Backup and restore VMs](#42-backup-and-restore-vms)
      * [4.2.1 Backup a single VM](#421-backup-a-single-vm)
      * [4.2.2 Backup the current state of all VMs](#422-backup-the-current-state-of-all-vms)
      * [4.2.3 Restore a backup of virtual machine](#423-restore-a-backup-of-virtual-machine)


    

## 1. INTRODUCTION


### 1.1 Purpose
The purpose of this guide is to provide step-by-step instructions for setting up a QTO development environment relying heavily on virtualization in Windows. There is also a pdf version available at https://github.com/YordanGeorgiev/ysg-guides/blob/master/doc/pdf/ovb-on-win-virtualization-guide.pdf


### 1.2 Target setup
The target setup of this guide is a physical Windows machine (Host) operating a configurable virtual machine (Guest), which both have access to the Internet. The Guest will also have read and write access to a shared directory on the Host. 


### 1.3 Submitting suggestions
Should you find an error or want to suggest a change in the content of the document, feel free to clone this Github repository and create a merge request.


## 2. PREPARATION AND CONFIGURATION

This guide assumes that you have 64-bit Windows already installed on the Host, the computer is connected to the Internet and you installed a browser, for example, Firefox, Opera or Chrome. If you have 32-bit Windows, then use the appropriate 32-bit installers instead during this installation.

It is recommended to get NotePad++, TextPad, Atom or any other light text editor for quickly editing text and configuration files in the future.
https://notepad-plus-plus.org/downloads/


### 2.1 Install Strawberry Perl
Perl binaries, compiler (gcc) and related tools will be needed for proper deployment of QTO. Install a recommended version of Strawberry Perl from the official website to your Windows Host system:
http://strawberryperl.com/

### 2.2 Install Cygwin
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

### 2.3 Install VirtualBox
Install VirtualBox from this website by choosing "VirtualBox platform packages" -> "Windows hosts":
https://www.virtualbox.org/wiki/Downloads

Then download and install "VirtualBox Oracle VM VirtualBox Extension Pack".

### 2.4 Install Vagrant
Vagrant will be used together with VirtualBox to create a configured Guest virtual machine, where QTO will be run. Install Vagrant for Windows:
https://www.vagrantup.com/downloads.html

### 2.5 Configure Windows PATH variable
This step will enable to run one-liners with VBoxManage.exe to quickly change virtualization settings. It is also required for working with Cygwin.

Open the Advanced System Properties on Windows (`Win+R`, `sysdm.cpl`, Enter), switch to the Advanced tab, then click on Environment Variables button.
```
sysdm.cpl
```

Scroll down and select the variable "Path" under the "System variables" and click on the "Edit" button. Add directory of VBoxManage.exe to the line and click OK. The default installation directory for VBoxManage.exe is `C:\Program files\VirtualBox\`

Add the path of the Cygwin bin folder as well, so that Cygwin can be launched from the command line. Usually it is C:\cygwin\bin

Press OK to save the settings, then restart the computer.

## 3. VIRTUAL MACHINE DEPLOYMENT

At this stage we will download and create a Ubuntu 18.04 virtual machine using Vagrant and then install QTO on it.

### 3.1 Clone Github repository

First launch Cygwin by running `Cygwin` in command line. In a new installation of Cygwin, your home directory will be in C:/cygwin/home/<user>/, and can be accessed by the `~` shortcut.

Then create a directory called `opt`, get inside of it, clone QTO files from Github and navigate inside `qto` folder. Here are the commands to be executed inside Cygwin:
```
mkdir -p ~/opt; cd $_ ; git clone https://github.com/YordanGeorgiev/qto.git ; cd ~/opt/qto
```

### 3.2 Run deployment script

When this is done, run the deployment script:
```
./src/bash/deploy-vagrant-vm.sh
```

The script will download Ubuntu image from the Internet and copy a Vagrant configuration file from `/qto/cnf/tpl/vagrant/Vagrantfile` to the `qto` folder, then run `vagrant up` command to start the virtual machine.

If there are any errors, please check the Troubleshooting section of this guide.


### 3.3 Enable fully read/write access to a shared folder on the Host from the Guest
Edit the `/qto/Vagrantfile` to allow access to a directory on your Windows Host machine from the Linux Guest terminal. In this example `D:\opt\qto\` is the path on Host that will be shared, `/home/vagrant/opt/` is the path, where this folder will be available on the Guest.

```
config.vm.synced_folder "D:\opt\qto\", "/home/vagrant/opt/"
```


It should also be possible to add the folder using VBoxManage, however editing the Vagrantfile is the preferable way. Here the name of the share will be `qto`, the full directory path to the directory on the Host will be `D:\opt\qto\`, and finally the name of the virtual machine to enable the full read/write access for will be `qto_dev-qto-vagrant_1584955571704_40830`. Alternatively, you can configure it in VirtualBox image Settings, Shared Folders tab.

```
# how-to add a shared folder on the Host
VBoxManage sharedfolder add "qto_dev-qto-vagrant_1584955571704_40830" -name "qto" -hostpath "D:\opt\qto\" -automount
```

The names of the created virtual machines can be seen using `VBoxManage list vms` command in Cygwin on Host.

#### 3.4 SSH to Guest

After the virtual machine started, run the following command to establish an SSH session into a running virtual machine to give you shell access.

```
vagrant ssh
```

If this does not work at once, you may need to start VirtualBox, launch the image from there, then install open-ssh server on the Guest system.
```
sudo apt-get install -y openssh-server
sudo systemctl enable ssh
```

Them set Port forwarding from `127.0.0.1` port `2522` to `10.0.2.15` port `22` in VirtualBox image preferences, Network, Advanced, Port forwarding in order to connect via SSH.

#### 3.4 Install the Guest Additions prerequisites
After getting access to Guest, install the Guest Additions prerequisites by issuing the following command inside Terminal:

```
sudo apt-get install -y build-essential make gcc linux-headers-$(uname -r) linux-headers-generic make linux-source linux-generic linux-signed-generic
```

#### 3.5 Install VirtualBox Guest Additions
Do not use the .iso file to download and the installer from there - it will not work. Install `virtualbox-guest-dkms` package instead by running this command in the Guest system.

```
sudo apt-get install -y virtualbox-guest-dkms
```

#### 3.6 Add yourself to the vboxsf group
Add yourself to the vboxsf group in order to be able to edit as non-root from your VM the files on your Host machine. `ubuntu` is the user name on Guest.

```
# remount /etc/fstab without rebooting
sudo mount -a
    
sudo usermod -G vboxsf -a ubuntu
```

#### 3.7 Reboot and verify
Reboot the virtual machine and login via SSH to verify the file sharing. 

In bash shell on Host
```
# ssh to the VM, alternatively vagrant ssh
ssh vagrant@localhost -p 2522

# check as yourself that you have 
find /vagrant
```

## 4. MAINTENANCE AND OPERATIONS
This section contains maintenance and operational activities around the virtualization. 

### 4.1 Start and stop VMs

To start a virtual machine navigate to the `opt` directory on your Host, then clone `ysg-guides` repository there.

```
cd ~ ; git clone git://github.com/YordanGeorgiev/ysg-guides
```

Then get inside 'ysg-guides\src\cmd\' and execute the following cmd file with the name of the Guest system as a parameter. In this example the name of the virtual machine is `qto_dev-qto-vagrant_1584955571704_40830`. 

```
vm-start qto_dev-qto-vagrant_1584955571704_40830
```

To stop a virtual machine execute the following cmd file with the name of the Guest system as a parameter. 

```
vm-stop qto_dev-qto-vagrant_1584955571704_40830
```

### 4.2 Backup and restore VMs

#### 4.2.1 Backup a single VM
To backup a single VM issue the following command:

```
# first list all your VMs 
VBoxManage list vms

# select the Guest VM
VBoxManage export qto_dev-qto-vagrant_1584955571704_40830 -o qto_dev-qto-vagrant_1584955571704_40830.ova
```

#### 4.2.2 Backup the current state of all VMs
If you performed the installations and configurations as described above, you will be able to backup any or all of your Guests by simply backing up the VMs folder.

```
# execute this in bash shell to display necessary commands to export all VirtualBox VMs in Windows into the current directory
while read -r vms ; do echo VBoxManage export "$vms" -o "$vms".ova ; done < <(VBoxManage list vms|cut -d'"' -f2)
```

#### 4.2.3 Restore a backup of virtual machine
Copy the backed up folder into your Windows Hosts virtual machines folder. By default it is located in `C:\Users\%USERPROFILE%\VirtualBox\`

Open Oracle VirtualBox. In the menu choose `Machine`,  `Add...`, then navigate to the just copied `qto_dev-qto-vagrant_1584955571704_40830.ova`.
