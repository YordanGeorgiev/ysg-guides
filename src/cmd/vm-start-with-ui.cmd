:: purpose to speed up Oracle VirtualBox vm top
:: usage: Start , Run , type: vm-start vm_name
:: confs: VBoxManage.exe should be in your %PATH%
:: confs: add to %PATH% VBoxManage.exe and vm-stop.cmd

VBoxManage startvm "%1"
@echo off
ping -n 6 localhost > NULL