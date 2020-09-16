# file:linux-cheat-sheet.sh v.1.9.5 docs at the end 

sudo hostnamectl set-hostname qto.fi


# how-to use tee for appending multiline text with sudo ... for example to disable ip06
cat <<EOF | sudo tee -a /etc/sysctl.conf > /dev/null 
net.ipv6.conf.all.disable_ipv6 = 1
net.ipv6.conf.default.disable_ipv6 = 1
net.ipv6.conf.lo.disable_ipv6 = 1
EOF


# where are the "too-long lines " files
find . -type f -exec grep --color=always -nHPo '.{0,300}to-srch.{0,300}' {} \;
# now repeat the search by excluding those bastards 
find . -type f ! -name '*.main.js' ! -path './build*' -exec grep --color=always -nHio 'to-srch' {} \;


alias tarx='tar -zxvf'
alias tarc='tar -zcvf'

# create tar
tar -cpzf tar tar-package.tar.bz src/path
tar -cpjf tar tar-package.tar.bz2 src/path

# extract tar
tar -xzf tar-package.tar.bz -C /tgt/path/
tar -xjf tar-package.tar.bz2 -C /tgt/path

# network cards info
sudo arp -a

# start networking 
sudo netstat -tulpn

# show th
sudo route -n

# which is my default gateway
sudo ip route | grep default
sudo ifconfig

iptables -A INPUT -i eth0 -p tcp -m tcp --dport 13306 -j ACCEPT
iptables -L
# stop  networking 

# when you work on more than 2 boxes at once you need thiso ne
export PS1='`date "+%F %T"` \u@\h  \w \n\n  '

tee ~/generated-script.sh > /dev/null << EOF
some content , cmd substritutions works too
spawn $(which mysql)
EOF

# how-to store std err output to var
VAR_FROM_ERR=$( { command; } 2>&1 )

# dns troubleshooting
dig host-dns.name

host host-dns.name
nslookup
# type g=max
# type host-dns.name

# how interfaces on host 
ip link show

# trace tcp with tcpdump
sudo tcpdump -i enp0s3 -l > dat & tail -f dat

# trace ssl trafic with sssldump
ssldump -k /etc/stealmykeys/test.key -i eth0 -dnq host 10.41.12.50

w# get the Ctrl + J tmux 
wget -O ~./.tmux.conf https://raw.githubusercontent.com/YordanGeorgiev/ysg-confs/master/.tmux.conf.host-name

# create a new tmux session
tmux new -s "mngmt-1"

#find in files with colors
export to_srch=perl
find . -type f -exec grep -nHi --color=always -R $to_srch {} \; | less -R
find . -name '*.pm' | xargs -P 5 grep -nHP --color=always -P $to_srch | less -R


# and test 
for bin in `echo ftp telnet wget ssh sftp curl grep egrep`; do echo "$bin path:"; which $bin ;done ; 

# while loop
find `pwd` | { while read -r file ; do echo "$file" ; done ; }

# fork processes with while
c=0
cat "$list_file" | { while read -r jira_issue ; do c=$((c+1)) ; test $c -eq 5 && sleep $c && export c=0 ; \
( sh /maintenance/ip/sfw/sh/jira --action progressIssue --issue $jira_issue --step 41 )& done }

#-- start - search and replace recursively in both files and file paths
export dir='<<type the dir>>'
export to_srch='what_to_srch'
export to_repl='what_to_replace'

#-- srch and repl %var_id% with var_id_val in dirs in $component_name_dir_tmp
find "$dir" -not \( -wholename "./.git" -prune \) -type d |\
perl -nle '$o=$_;s#'"$to_srch"'#'"$to_repl"'#g;$n=$_;`mkdir -p $n` ;'
find "$dir" -not \( -wholename "./.git" -prune \) -type f |\
perl -nle '$o=$_;s#'"$to_srch"'#'"$to_repl"'#g;$n=$_;rename($o,$n) unless -e $n ;'

#-- stop  - search and replace recursively in both files and file paths

#-- start - srch and repl %var_id% with var_id_val in files in $dir_to_srch_and_repl
find "$dir" -type f -not \( -wholename "./.git" -prune \) -exec perl -pi -e "s#$to_srch#$to_repl#g" {} \;
find "$dir/" -type f -name '*.bak' | xargs rm -f
#-- stop  - srch and repl %var_id% with var_id_val in files in $dir_to_srch_and_repl

on_parhaat

# START === create symlink
export lnk_path=/opt/phz
export tgt_path=/hos/opt/phz
mkdir -p `dirname $lnk_path`
test -L $lnk_path && unlink $lnk_path
ln -s $tgt_path $lnk_path
ls -la $lnk_path; 
# STOP === create symlink

echo y;echo o conf prerequisites_policy follow;echo o conf commit)|cpan

# get a nice prompt 

# nice listing
find . -type f -exec stat -c '%n %y' {} \; | sort -n | less
# check permissions effectively 
find . -type f -exec stat -c "%U:%G %a %n" {} \; | less

# skip / omit a dir in find
find . -not -path no-go

# aliases
# show dirs with nice time newest modified on top 
alias ll='ls -alrt --time-style=long-iso'


# find the only the uniq file names of specific file type 
find `pwd` -name '*.xml' | perl -pe 's/(.*)(\\|\/)(.*)/$3/;' | sort  | uniq -u

# how-to find in files - e.g. search by a perl regex in files and redirect the output to vim 
find `pwd` -name '*.pm' -exec grep -inHP -A 1 'sub [a-zA-Z0-9]*\s+\{' {} \; | vim -

# how-to search for a regex and build the ready open vim to found line cmds
find $dir -name '*.ext' -exec grep -nHP 'regex' {} \; | perl -ne 'm/^(.*):(\d{1,10})(.*)/g;print "vim ". "+$2 " . "$1 \n"'

grep -HrnP '10(\.\d+){3}' .

# go the previous dir you where 
cd -
pushd .; popd

#how-to check opened ports with nmap
nmap -sT -O localhost

# get selinux security context
ls -al --lcontext $dir

# change the selinux security context 
chcon -vR -u system_u -r object_r -t httpd_sys_content_t $dir

# use rsync to preserve permissions, archieve and NOT create tgt dir src_dir/

export ssh_server=csitea.net #cgfinics.com #qto.fi
export ssh_user=ubuntu
export src_dir=/home/ubuntu/opt/
#export ssh_idty=~/.ssh/id_rsa.aws-ec2.cg-finics.prd
# export ssh_idty=~/.ssh/id_rsa.aws-ec2.qto.0.8.6.prd
export ssh_idty=~/.ssh/id_rsa.aws-ec2.qto.prd
export tgt_dir=/hos/opt/
rsync -e "ssh -l USERID -i $ssh_idty" -av -r --partial --progress --human-readable \
	--stats $ssh_user@$ssh_server:$src_dir $tgt_dir
clear ; find $tgt_dir -type d -maxdepth 1|sort -nr| less

rsync -e "ssh -l USERID -i ~/.ssh/id_rsa.aws-ec2.qto.prd" -av -r --partial --progress --human-readable \
	--stats --delete-excluded ubuntu@$ssh_server:$src_dir $tgt_dir



rsync -av -r --partial --progress --human-readable --stats --delete-excluded $src_dir tgt_dir
rsync -v -X -r -E -o -g --perms --acls $src_dir $tgt_dir
rsync -v -r --partial --progress --human-readable --stats $src_dir $tgt_dir
rsync -v -r --partial --progress --human-readable --stats $src_dir/$f $tgt_dir/$f

rsync -avzhXrEog $ssh_user@$ssh_server:$src_dir $tgt_dir
rsync -avzhXrEog $src_dir $ssh_user@$ssh_server:$tgt_dir







while read line_with_spaces ; do sh /path/to/script.sh "$line_with_spaces" ; done < $file_with_lines_with_spaces

export file_name_to_filter=infa-reporter
stat -c "%n %y" *.zip | perl -ne 'm/^(.*?) (.*)/g; printf "%-70s %-50s \n" , "$1" , "$2"' | sort -r -k 2 | grep -i $file_name_to_filter
stat -c "%y %n" *.zip | sort -nr | less


# The ultimate "find in files"
find /etc/httpd/ -type f -print0 | xargs --null grep -nHP 'StartServers\s+\d' | less
# for loop
for file in `find / -type f \( -name "*.pl" -or -name "*.pm" \) -exec file {} \; | grep text | perl -nle 'split /:/;print $_[0]' `; do grep -i --color -nH 'string_to_search'  $file ; done ;

#  or even faster , be aware of funny file names xargs -0
find / -name '*bak' -print0 | xargs --null grep -nPH 'curl'

# find and replace recursively
find . -name '*.html' -print0 | xargs -0 perl -pi -e 's/foo/bar/g'

# how-to check disk space
find $dir -maxdepth 2 -type d -exec du -B M --max-depth=1 {} \; | sort -nr | less

# find all the files greather than 100 MB , sort them by the size and print their sizes 
find $dir -type f -size +2M -exec du -B M {} \; | sort -nr | less 

du -B M --max-depth 3 $dir | perl -nle 's#\s+# #g;print' | perl -ne 'm/^(.*?) (.*)/g; printf "%10s %-50s \n" , "$1" , "$2"' | sort -nr -k1 | less

# how-to search bunch of tar.gz files 
cmd="zgrep $StringToFind '{}' >> $FileToOutput"
find ${DirFindRoot} -type f  -name ${nameFilter} -print0 | xargs -0 -I '{}' sh -c "$cmd"

# disk usage of users under the /home directory in MB
export dir=/data/reseller/tmp/;
clear;du -all --block-size=1M $dir --max-depth=2 | sort -n | perl -ne '@a=split /\s+/g;$a[0]=~s/(?<=\d)(?=(?:\d\d\d)+\b)/ /g;printf "%15s %10s",$a[0],"$a[1]  \n" '

# show in megs and sort each folder
find $dir -type d -exec du --summarize -B M {} \; | sort -nr | perl -ne '@a=split /\s+/g;$a[0]=~s/(?<=\d)(?=(?:\d\d\d)+\b)/ /g;printf "%15d %10s",$a[0],"$a[1]  \n" '| less

tcpdump dst 10.168.28.22 and tcp port 22
tcpdump dst 1.2.81.2.8.212 

# record the current session via script
mkdir -p ~/data/log/script ; script -a ~/data/log/script/$USER.linux.`date +%Y%m%d%H%M%S`_script.log


# take the last 5 commands for faster execution to the temp execution script
tail -n 5 /root/.bash_history >> /var/run.sh

# I saw the command cd /to/some/suching/dir/which/was/very/long/to/type
echo so I redid it and saved my fingers
!345

#how-to check my history without the line numbers  
history | cut -c 8- | grep env


# how to deal with command outputs
command | filtercommand > command_output.txt 2>errors_from_command.txt


#  find the files having os somewhere in their names and only those having linux
find . -name '*os*' | grep linux | less

# find all xml type of files and display only the rows having wordToFindInRow
find . -name '*.xml' -exec cat {} \;| grep wordToFindInRow | less


# START ::: bash shortcuts

Ctrl + A # Go to the beginning of the line you are currently typing on
Ctrl + E # Go to the end of the line you are currently typing on
Alt + F # move a word forward
Alt + B # move a word backwards
Ctrl + R # cycle back the history 
# the most efficent way to search your history is to hit Ctrl R and
# type the start of the command. It will autocomplete as soon as theres
# a match to a history entry, then you just hit enter. If you want to
# complete the command (add to it ) use the right arrow to
# escape from the quick search box ...
Ctrl + I # cycle forth the history ( might need separate config ) 
# how-to edit complex commands via the export EDITOR=vim
Ctrl + X,E
# STOP ::: bash shortcuts 

# how-to mount an usb stick
# remember to change the path other wise you will get the device is busy errror
mkdir /mnt/usbflash
mount /dev/sdb1 -t vfat /mnt/usbflash

mount /vagrant -t /mnt/hgfs/vagrant
mount -t vmhgfs .host:/mnt/hgfs/vagrant /vagrant 

umount /mnt/usbflash

#display the first 20 lines of the file
head -n 20 too-long-file 

#start e-mail 
# how to restart a service initiated at startup
/etc/rc.d/init.d/sendmail start | stop | status | restart

# how-to send via e-mails the files of a dir with mailx
export dir=`pwd`
export attachments=$(find $dir -type f| perl -ne 'print "-a $_"'| xargs)
echo $attachments | mailx $attachments -s "$dir files" $MyEmail

mailx $(find $dir -type f| perl -ne 'print "-a $_"'| xargs) -s "$fir files" $MyEmail < `echo $(find $dir -type f| perl -ne 'print "-a $_"'| xargs)`

#stop e-mail

# see all the rules associated with the firewall
sudo iptables -L -n -v --line-numbers
# save all the rules in a "applicable" format
sudo iptables -S
# remove a rule insttead of -A use -D 
sudo iptables -A INPUT -p tcp -m state --state NEW -m tcp --dport 8080 -j ACCEPT
#sudo iptables -D INPUT -p tcp -m state --state NEW -m tcp --dport 8080 -j ACCEPT


gunzip *file.zip

# how to ensure the sshd daemon is running
ps -ef | grep sshd


# how to kill process interactively
killall -v -i sshd


open a file containing "sh" in its name bellow the "/usr/lib" directory

:r !find /usr/lib -name *sh*

go over the file and gf

#which version of Linux I am using
uname -a
# on ubuntu 
lsb_release -a 

#To restart a service
service sshd restart  
service --status-all --- show the status of all services


# change the owneership of the directory recursively
chown -vR $usr:$grp $dir


# perform action recursively on a set of files
find . -name '*.pl' -exec perl -wc {} \;


for file in `find . -type f`;do echo cp $file ./backups/; done;
for file in `ls *.docx -1`;do echo cp $file ./backups/$file.`date +%Y%m%d%H%M%S`.docx;done;


# make Bash append rather than overwrite the history on disk:
shopt -s histappend

# henever displaying the prompt, write the previous line to disk:
PROMPT_COMMAND='history -a'


# than run the script
#how-to replace single char in file
tr '\t' ',' < file-with-tabs > file-with-commas

# Allow access to the box from only one ip address


# create a backup file based on the timestamp on bash
cp -v fileName.ext fileName.ext.`date +%Y%m%d_%H%M%S`.bak

#check disk space left
df -a -h | tail -n +2   | perl -nle 'm/(.*)\s+(\d{1,2}%\s+(.*))/g;printf "%-20s %-30s %-90s \n","$2",$3,$1' | sort -nr | less
df -a -B M | column -t | sort -nr -k 5
df  -h ***

# how-to get running processes 
ps -ef --forest 

# how-to kill misbehaving process ... you will need to adjust the -f 2 part 
# depending on the output of the ps -ef command above 
for pid in $(ps -ef | grep procToFind | perl -ne 's/\s+/ /g;print $_ . "\n";' | cut -d ' ' -f 2) ; do echo kill -9 $pid ; done ;
for pid in $(ps -ef | grep chrome | perl -ne 's/\s+/ /g;print $_ . "\n";' | cut -d ' ' -f 2) ; do echo kill -9 $pid ; done ;


#how-to create relative file paths tar package recursively fromm a dir
cd $roo_dir_to_start_tarring_relative_paths_from
tar -cvzpf $pckg_to_create.tar .
# exctract tar file into cd  
tar -xvf $pck_to_exctract_to_cwd.tar

#how-to create tar archieve
tar cvf $archive_name.tar $dir/

#how-to unpack tar file
tar xvf $file

#how-to unpack gz archive
gzip -cd $file | tar -xvf -


# print line number 52
sed -n '52p' # method 1
sed '52!d' # method 2
sed '52q;d' # method 3, efficient on large files

# check NFS 
mount -v
nfsstat -m

# START === user management
#how-to add a linux group
export group=grpqto
export gid=1010
sudo groupadd -g "$gid" "$group"
sudo cat /etc/group | grep --color "$group"

export user=atc
export uid=1111
export home_dir=/home/$user
export desc="atc"
#how-to add an user
sudo useradd --uid "$uid" --home-dir "$home_dir" --gid "1000" \
--create-home --shell /bin/bash "$user" \
--comment "$desc"
sudo cat /etc/passwd | grep --color "$user"
groups "$user"


# modify a user
usermod -a -G $group $user

# change the password for the specified user (own password)
passwd $user 
#how-to forces to change password when logging in for the first time
passwd -f login 
#change user pass to expire never 
chage -I -1 -m 0 -M 99999 -E -1 $user
# and check results 
chage -l $user


#Ei should not return anything !!!
passwd -s -a | grep NP (=No Password)

#delete an user
userdel $user
#administer the /etc/group file
gpasswd: 
# START === user management


#how-to extracts rpm packages contents
export ins=foo-bar.rpm
rpm2cpio $ins |cpio -id

#how-to extract or uncompress  *.tar.gz 
gzip -dc *.tar.gz | tar -C "$tgt_path" xvf -

cd "$tgt_path/foo-bar-dir"

#--- show all installed packages
rpm -dev
# search for package name
rpm -qa | grep --color $package


#how-to build binaries as a non-root 
./configure --prefix=$HOME && make && make install

#exctract a single file:
gzip -dc fileName.tar.gz | tar -xvf - $file

find . -name '*.log' -print | zip cipdq`date +%Y%m%d%H%M%S` -@
# find several types of files 
find . -type f \( -name "*.pl" -or -name "*.pm" \)

find / -type f | xargs grep -nH 'curl'

# print the word to find + the next 3 lines
grep -A 3 -i "theWordToFind" demo_text


find . -type f -name '*.sh' -print -exec grep -n gpg {} \;
# create a list of files
find . -print0 | xargs -r0 echo "$@"

#how-to encrypt a file
gpg -c $file
#how-to decrypt a file
gpg $file

# where am I
uname -a ; 
# who am I 
id ; 
# when this is happening 
date "+%Y-%m-%d %H:%M:%S" ; 

# reboot ... !!! BOOM BOOM BOOM !!!
shutdown -r now 

# shutdown the whole system 
shutdown -f -s 00

#how-to kill a process 
ps -aux | grep $proc_to_find
pidof $prod_to_find
kill -9 $proc_to_find

# which processes are listening on my system
netstat --tcp --listening --programs
netstat --tcp
netstat --route
# how-to display the kernel routing table 
sudo netstat -nr

# how-to get my current gateway ip
ip route | grep default


# get system info
cat /proc/cpuinfo | less
cat /proc/meminfo | sort -nr -k 2 \
| perl -ne 'split /\s+/;printf ("%-15s %20d MB \n" , "$_[0]" , ($_[1]/1024))'
fdisk -l

k
# check memory usage
egrep --color 'Mem|Cache|Swap' /proc/meminfo

# show the top processes
top
# now press Shift + o, and choose the field to sort by 

# running processes status 
ps -auxw | less 
ps -ef | less 
#List all currently loaded kernel modules
lsmod | less 
#Displays the system's current runlevel.
/sbin/runlevel
# get the Processes attached to open files or open network ports:
lsoff | less 
# monitor the virtual memory 
vmstat 
# show the free memory
free -m


#Display/examine memory map and libraries (so). Usage: pmap pid
ps -aux | grep $proc_name_to_pmap
pmap   $prod_id_to_pmap
# STOP === system monitoging commands

#how-to sort output by a delimited by single delimiter column 
# in this example the - char is used for delimiter , the output is 
# by their sending sequence , use proper file naming convention files 
# ls -1 gives us:
# fileBeginningTillFirstDelimiter-TheColumnToSortBy-TheRestFromTheFileNameDelimiter
ls -1 | awk -F1 'BEGIN {FS="-"};{print $2 "¤" $1 "-" $2 "-" $3 }' | sort -nr | cut -d ¤ -f 2,5 
# the same approach with perl
ls -1 | perl -p -i -e 's/^([^\-]*)(\-)([^\-]*)(\-)([^\-]*)/$3¤$1.2.8$4$5/g' | sort -nr | cut -d ¤ -f 2,5  


# ==================================================================
# START Jobs control 
# start some very long lasting command 
find / -name '*.crt' | less 
# now press Ctrl + Z 
# the terminal says "Jobs stopped"
# now check the open jobs 
jobs
# you should see something like 
# [1]+  Stopped                 find / -name '*.crt' | less
# now put the job in the background and start working on something else by Ctrl + Z 
bg 1
# run the next command 
# how-to copy file via scp by using specificy identity
scp -v -o "IdentityFile /home/userName/.ssh/id_rsa" /data/path/dir/* \
userName@ServerHostName.Domain.com:/Server/tgt/Dir/

# now again stop the job first by Ctrl + Z 
# check again the running jobs 
jobs 
# use should see the both of the jobs started 
# now put the first on in the forground 
fg 1
# Repeat that several times untill you get it ; ) !!!

# start command in the background
command1 &



# how-to redirect STDERR STDOUT to log file 
sh $script.sh | tee 2>&1 $log_file

# how-to start a separate shell 
( command &) &

# get the STDERR and STDOUTPUT 
output=$(command 2>&1)

# how-to detach an already started job from the terminal
jobs 
disown -h %1
# Delete all jobs if jobID is not supplied.
disown -a

# how-to start 
nohup log_script.sh &

# run a proc every 2 seconds
watch -n 2 "$cmd_to_run"

# STOP  Jobs control 
# ==================================================================

nicedate=`date +%Z-%Y%m%d%H%M%S`

# kill a process by name 
ProcNameToKill=listener-nat_filter_caller.sh
# ps -ef | grep wget | perl -ne 'split /\s+/;print "kill $_[7] with PID $_[1] \n";`kill -9 $_[1];`'
ps -ef | grep $ProcNameToKill | grep -v "grep $ProcNameToKill" | \
perl -ne 'split /\s+/;print "kill $_[7] with PID $_[1] \n";`kill -9 $_[1];`'

# how-to display human readable file sizes on systems with stupid du
# of course you would have to have perl next_line_is_templatized
find $dir -type f -exec du -k {} \; | \
perl -ne 'split /\s+/;my $SizesInMegs=$_[0]/1024; \
printf ( "%10d %10s \n" , "$SizesInMegs" , "MB $_[1]")' | sort -nr 


export dir=/
echo sizes in MB
find $dir -type f -exec du -k {} \; | \
perl -ne 'split /\s+/;my $SizesInMegs=$_[0]/1024; \
printf ( "%10d %-100s \n" , "$SizesInMegs" , "$_[1]")' | sort -nr | more


#who has been accessing via ssh 
for file in `find /var/log/secure* | sort -rn` ; do grep -nHP 'user' $file ; done; | less


#print files recursively 
dir=/opt/
clear;find $dir -type f -exec ls -alt --time-style=long-iso --color=tty {} \; | \
perl -ne 'split(/\s+/);printf ( "%10s %2s %-20s \n" , "$_[5]", "$_[6]", "$_[7]") ; ' | sort -nr

#how-to print relative file paths to /some/DirName with perl one liner 
find /some/DirName -type f | perl -ne 'split/DirName\//;print "$_[1]"  '

# see nice dir recursively listing newest first
dir=/tmp
find $dir -name '*.tmp' -exec ls -alt --time-style=long-iso --color=tty {} \; | \
perl -ne 'split/\s+/;print "$_[5] $_[6] $_[7] \n" ;' | sort -nr | less

# how-to sort files based on a number sequence in their file names
# list dir files , grap a number from their names , print with NumberFileName, sort , \
# print finally the names without the Number but sorted 
ls -1 | perl -ne 'm/(\d{8})/; print $1 . $_ ;' | sort -nr | perl -ne 's/(\d{8})//;print $_'


# show me a nice calendar 
cal -m -3

# local port forwarding
ssh -L [BIND_ADDRESS:]PORT:HOST:HOSTPORT HOSTNAME

# remote port forwarding
ssh -R [BIND_ADDRESS:]PORT:HOST:HOSTPORT HOSTNAME

# START === how-to enable port forwarding via ssh or ssh tunnelling
export local_host_port=30000
export host1_user=phz
export host1=mac-host
export host1_port=30000
export host2=192.168.56.115
export host2_user=ysg
export host2_port=13306

# Tunnel from localhost to host1 and from host1 to host2
ssh -tt -L $local_host_port:localhost:$host1_port $host1_user@$host1 \
ssh -tt -L $host1_port:localhost:$host2_port $host2_user@$host2
# STOP === how-to enable port forwarding or tunnelling



# START === cron scheduling 
#edit the crontab
crontab -e
# view the crontab
crontab -l 
0 1 * * *
# * * * * * command to be executed
# - - - - -
# | | | | |
# | | | | +- - - - day of week (0 - 6) (Sunday=0)
# | | | +- - - - - month (1 - 12)
# | | +- - - - - - day of month (1 - 31)
# | +- - - - - - - hour (0 - 23)
# +--------------- minute
# STOP === cron scheduling 


#how-to limit the resources of the current session 
help ulimit 

nameTerminal $USER@`hostname`_ON_`pwd`__at__`date +%Y-%m-%d_%H:%M:%S`


# change user password expiry information
for usr in "$userlist"; do sudo passwd $usr; sudo chage -E -1 -M -1 $usr; sudo chage -d0 $usr; done


#how-to check the file encoding
file_encoding=$(file -bi $file | sed -e 's/.*[ ]charset=//')


# Purpose: 
# to provide a simple cheat sheet for most of the Linux related commands

# usefull web sources: http://www.cyberciti.biz
# how-to add new repository to yum
yum-config-manager --add-repo http://www.example.com/example.re

#how-to view installed packages with yum on RH


yum list installed | less
yum clean all 
yum -y install perl
# update all but the linux kernel packages
yum -y --exclude=kernel\* update

# how-to view installed packages on ubuntu 
sudo dpkg -l

/nz/kit/sbin/sendMail -dst first.last@company.com -msg "subject line" -bodyTextFile $outfile -removeFile

# start putty with preloaded session on windowz
cmd /c start /max putty -load username@hostname


# how-to enable pw auth on apache
pw_file=/var/www/html/maint/.htpasswd
user=mmt
htpasswd -c $pw_file $user

#how-to change the access and mofication timestamp
ts='201401181205.09'
touch -a -m -t "$ts" "$file"

# how-to search for a packge
sudo apt-cache search keyword

# where did a package come from
apt-cache policy $package

# how-to install packages on ubuntu
sudo apt-get -y install $package_name
# howto install packages on red-hat
yum install $package_name

#v1.9.5 how-to use text editor for longer command typing
set EDITOR=vim
#Ctrl+X,E

#v1.9.5 - how-to get variations by curly expansions
echo {A,B,C}{0,1,3}

#how-to convert file encoding 
iconv -f 'iso-8859-1' -t 'utf-8' "$file"



# how-to load document with wget by using cookies.txt
export url=www.google.com
export out_file=$proj_dir/docs/site/data/issues/
wget $url --user-agent=agent --load-cookies=~/.cookie.txt --output-document=$out_file

#how-to perform a command frequintly 
while $(sleep 0.2); do date "+%Y:%m:%d %H:%M:%S"; done


# how-to 
cat << "EOF" > path/to/instructed.cnf
{
foo_var=bar_val
}
EOF
#^^^ no space after the new line

# how-to automate silent installations
# Pass input to the installer using a here-document
sudo mysql_secure_installation <<EOF
$password
N
Y
Y
Y
Y
EOF


# start sudo

su - user -c "cd `pwd`; bash" 
# stop sudo 


# how-to verify cert from the cmd line
echo | openssl s_client -showcerts -servername gnupg.org -connect gnupg.org:443 2>/dev/null | openssl x509 -inform pem -noout -text

# how-to create a self-signed certficate ...
openssl req \
   -newkey rsa:2048 -nodes -keyout host-name.key \
   -x509 -days 365 -out host-name.crt

# how-to find the total size of files in a directory 
export dir="." ; find $dir -name '*.csv' -exec du -ch {} + | grep total$
23G     total

# how-to count the lines of multiple files of type in a directory 
export dir="." ; find $dir -name '*.csv' -exec cat {} + | wc -l

#
# useful sources - hint: google site:<site>
# http://www.cyberciti.biz
# http://www.yolinux.com/TUTORIALS/LinuxTutorialSysAdmin.html#MONITOR
# http://www.commandlinefu.com/commands/browse/sort-by-votes
# http://wiki.bash-hackers.org/
#
# eof file:linux-cheat-sheet
