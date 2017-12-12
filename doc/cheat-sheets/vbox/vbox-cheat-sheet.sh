#file: docs/cheat-sheets/vbox/vbox-cheat-sheet.sh


# how-to add a shared folder on the host
VBoxManage sharedfolder add "host-name" -name "vshare" -hostpath "C:\var"


# get the uuid's of your vms
VBoxManage list vms | column -t | sort

# how-to use host's vpn with host-only network on nic1 and nat on nic2 confs
VBoxManage modifyvm 8e2562ee-61e3-48da-9381-092fc1ab909c --natdnsproxy1 on
VBoxManage modifyvm 8e2562ee-61e3-48da-9381-092fc1ab909c --natdnshostresolver1 on

# how-to start a vm without ui  
VBoxManage startvm "vm-name" --type headless

# how-to start a vm with detachable ui ( no 3D acceleration )
VBoxManage startvm "vm-name" --type separate

# how-to save the current state of the vm 
VBoxManage controlvm "vm_name"  savestate

# how-to start a vm with ui  
VBoxManage startvm "vm-name"

# how-to shutdown a vm
VBoxManage controlvm "vm_name" poweroff

# add port forwarding from host to guest
VBoxManage modifyvm "vm_name" --natpf1 "5001,tcp,,5001,,5001"

#how-to check network settings 
VBoxManage showvminfo "vm_name" | grep NIC

# in bash how-to export all myy Virtual box vms in Windows in the current dir
while read -r vms ; do echo VBoxManage export "$vms" -o "$vms".ova ; done < <(VBoxManage list vms|cut -d'"' -f2)

#in cmd how-to export all myy Virtual box vms in Windows in the current dir in cmd
for /f "tokens=1 delims= " %i in ('VBoxManage list vms') do VBoxManage export %i -o %i.ova

#how-to resize the virtual disk
VBoxManage modifyhd "C:\Users\ysg\VirtualBox VMs\doc-pub-host\doc-pub-host-disk1.vmdk" --resize 20000

#you reserved too little space during installation ?! No problem resize the virtual disk :
VBoxManage clonehd "C:\Users\ysg\VirtualBox VMs\doc-pub-host\doc-pub-host-disk1.vmdk" "C:\Users\ysg\VirtualBox VMs\doc-pub-host\doc-pub-host-disk.vdi" --format vdi
VBoxManage modifyhd "C:\Users\ysg\VirtualBox VMs\doc-pub-host\doc-pub-host-disk.vdi" --resize 20480

VBoxManage guestproperty enumerate doc-pub-host | grep -i Net | grep -i ip



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
