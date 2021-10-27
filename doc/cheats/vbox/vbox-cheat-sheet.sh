#file: docs/cheat-sheets/vbox/vbox-cheat-sheet.sh

# how-to get the ip of already booted guest
VBoxManage guestproperty enumerate sat | grep /VirtualBox/GuestInfo/Net/0/V4/IP

# check ip the of the guest 
for i in {1..9}; do sudo ifconfig -a | grep -i -A 1 enp0s$i | grep -i inet | awk '{print $2}'; done


# mount the cdrom
sudo mkdir -p /mnt/cdrom ; sudo mount /dev/sr0 /mnt/cdrom
# you should see the msg on the next line:
# mount: /mnt/cdrom: WARNING: device write-protected, mounted read-only.


# run the installer 
 cd /mnt/cdrom ;sudo sh VBoxLinuxAdditions.run
 Cycle through the prompts and once you finish installing, let it reboot

# add yourself to the sudoers group, to avoid typing passwords 
test $(grep `whoami` /etc/sudoers|wc -l) -ne 1 && echo $(whoami)' ALL=(ALL) NOPASSWD: ALL'|sudo tee -a /etc/sudoers



# shutdown the vm 
VBoxManage controlvm "sat" poweroff

# add a share folder 
VBoxManage sharedfolder add "sat" --name hos --hostpath "/Users/$USER" --automount --auto-mount-point=/hos




cat << EOF | sudo tee -a /etc/fstab

# <file system> <mount point>   <type>  <options>       <dump>  <pass>
# hos /hos vboxsf bind,uid=1000,gid=1000,rw,umask=0000 0 0
hos /hos vboxsf rw,dmode=777,gid=1000,uid=1000,umask=0022

# eof file: /etc/fstab
EOF

sudo mount -a 
cat ~/.ssh/authorized_keys >> /hos/.ssh/authorized_keys
test -d ~/.ssh && rm -rv ~/.ssh
for path in `echo '.aws' '.ssh'` ; do ln -sfn /hos/$path ~/$path ; done ;
for path in `echo 'opt' 'var'` ; do ln -sfn /hos/$path ~/$path ; done ;


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



42888420
VBoxManage export $guest --output $guest.v1.0.0.ova

VBoxManage import $guest.v1.0.0.ova


sudo mount -t vboxsf hos /hos/

Src4StrapOn!

# how-to enable symlinks on 
export guest=u-20
export shared_folder_name=hos
VBoxManage setextradata "$guest" VBoxInternal2/SharedFoldersEnableSymlinksCreate/$shared_folder_name 1

ssh –R 443:localhost:443 -i ~/.ssh/id_rsa.ysg.Yordans-MacBook-Pro -p 5522 ubuntu@192.168.99.39

VBoxManage setextradata host-name VBoxInternal2/SharedFoldersEnableSymlinksCreate/hos 1

# how-to add a shared folder on the host
VBoxManage sharedfolder add "$guest" -name "vshare" -hostpath "/Users/ysg"

sudo VBoxControl sharedfolder list


# get the uuid's of your vms
VBoxManage list vms | column -t | sort

# how-to use host's vpn with host-only network on nic1 and nat on nic2 confs
VBoxManage modifyvm 8e2562ee-61e3-48da-9381-092fc1ab909c --natdnsproxy1 on
VBoxManage modifyvm 8e2562ee-61e3-48da-9381-092fc1ab909c --natdnshostresolver1 on

# how-to start a vm without ui  
VBoxManage startvm "$guest" --type headless

# how-to start a vm with detachable ui ( no 3D acceleration )
VBoxManage startvm "$guest" --type separate

# how-to save the current state of the vm 
VBoxManage controlvm "$guest"  savestate

# how-to start a vm with ui  
VBoxManage startvm "$guest"

# how-to shutdown a vm
VBoxManage controlvm "$guest" poweroff


# add port forwarding from host to guest
VBoxManage modifyvm "$guest" --natpf1 "5001,tcp,,5001,,5001"

#how-to check network settings 
VBoxManage showvminfo "$guest" | grep NIC

# in bash how-to export all myy Virtual box vms  in the current dir




#in cmd how-to export all myy Virtual box vms in Windows in the current dir in cmd
for /f "tokens=1 delims= " %i in ('VBoxManage list vms') do VBoxManage export %i -o %i.ova

#how-to resize the virtual disk
VBoxManage modifyhd "C:\Users\ysg\VirtualBox VMs\doc-pub-host\doc-pub-host-disk1.vmdk" --resize 20000

#you reserved too little space during installation ?! No problem resize the virtual disk :
VBoxManage clonehd "C:\Users\ysg\VirtualBox VMs\doc-pub-host\doc-pub-host-disk1.vmdk" "C:\Users\ysg\VirtualBox VMs\doc-pub-host\doc-pub-host-disk.vdi" --format vdi
VBoxManage modifyhd "C:\Users\ysg\VirtualBox VMs\doc-pub-host\doc-pub-host-disk.vdi" --resize 20480

VBoxManage guestproperty enumerate host-name | grep -i Net | grep -i ip



# nok Add an IDE controller with a DVD drive attached, and the install ISO inserted into the drive:
VBoxManage storagectl lp_host --name "IDE" --add ide
# ok 
VBoxManage storageattach lp_host --storagectl "IDE" --port 0 --device 0 --type dvddrive --medium "C:\var\pckgs\gnu\Ubuntu\ubuntu-16.04.1-desktop-amd64.iso"

VBoxManage modifyvm %VM% --ioapic on
VBoxManage modifyvm %VM% --boot1 dvd --boot2 disk --boot3 none --boot4 none
VBoxManage modifyvm %VM% --memory 1024 --vram 128
VBoxManage modifyvm %VM% --nic1 bridged --bridgeadapter1 e1000g0







#
# ---------------------------------------------------------
#    VersionHistory: 
# ---------------------------------------------------------
# export version=1.1.0
# ---------------------------------------------------------
# 1.1.0 -- 2016-12-01 08:42:59 -- ysg -- 
# 1.0.0 -- 2016-08-16 22:40:16 -- ysg -- 
# ---------------------------------------------------------

#eof file: docs/cheat-sheets/vbox/vbox-cheat-sheet.sh
