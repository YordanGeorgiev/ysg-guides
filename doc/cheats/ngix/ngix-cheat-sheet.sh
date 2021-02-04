# to stop the systemctl ngix server
sudo systemctl stop nginx

#To start the web server when it is stopped, type:
sudo systemctl start nginx

#To stop and then restart the service again, type:
sudo systemctl restart nginx

#By default, Nginx is configured to start automatically when the server boots. If this is not what you want, you can disable this behavior by typing:
sudo systemctl disable nginx

#To re-enable the service to start up at boot, you can type:
sudo systemctl enable nginx