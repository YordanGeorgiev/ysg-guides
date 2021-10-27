# file: ssh-cheat-sheet.sh

# how-to use sftp with remoteUserName having publicIdentity of PublicIdentityUserName
sftp -v -o "IdentityFile /var/www/.ssh-id/PublicIdentityUserName" \
-o "UserKnownHostsFile /var/www/.ssh-id/known_hosts" remoteUserName@ServerHostNameOrIpd


ssh -v -o ServerAliveInterval 300 -o ServerAliveCountMax 1 



# run the next command 
# how-to copy file via scp by using specificy identity
scp -v -o "IdentityFile /home/userName/.ssh/id_rsa" /data/path/dir/* \
userName@ServerHostName.Domain.com:/Server/Target/Dir/


#who has been accessing via ssh 
for file in `find /var/log/secure* | sort -rn` ; do grep -nHP 'user' $file ; done; | less

# START === how-to implement public private key ( pkk ) authentication 
# create pub priv keys on server
# START copy 
ssh-keygen -t rsa
# Hit enter twice 
# copy the rsa pub key to the ssh server
scp ~/.ssh/id_rsa.pub $ssh_user@$ssh_server:/home/$ssh_user/
# STOP copy
# now go on the server
ssh $ssh_user@$ssh_server

# START copy 
cat id_rsa.pub >> ~/.ssh/authorized_keys
cat ~/.ssh/authorized_keys
pfind ~/.ssh -exec stat -c "%U:%G %a %n" {} \;
rm -fv ~/id_rsa.pub
exit
# and verify that you can go on the server without having to type a pass
ssh $ssh_user@$ssh_server
# STOP COPY

# START copy 
ssh-keygen -t dsa
# STOP copy  
# Hit enter twice 
# START copy 
cat id_dsa.pub >> ~/.ssh/authorized_keys
cat ~/.ssh/authorized_keys
chmod -v 0700 ~/.ssh
chmod -v 0600 ~/.ssh/authorized_keys
chmod -v 0600 ~/.ssh/id_dsa
chmod -v 0644 ~/.ssh/id_dsa.pub
find ~/.ssh -exec stat -c "%U:%G %a %n" {} \;
rm -fv ~/id_dsa.pub
# STOP COPY
# STOP === how-to implement public private key authentication



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

# how-to restart the sshd service
service sshd restart

# eof file: ssh-cheat-sheet