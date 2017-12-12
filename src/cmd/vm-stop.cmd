:: vm-stop.cmd
:: purpose to speed up Oracle VirtualBox vm top
:: usage: Start , Run , type: vm-stop vm_name
:: confs: add to %PATH% VBoxManage.exe and vm-stop.cmd

VBoxManage controlvm "%1" poweroff
@echo off
ping -n 6 localhost > NULL