#file : docs/cheat-sheets/docker-cheat-sheet.sh

# how-to list all the images 
docker images --all

# how-to list all the containers
docker ps -a

# how-to remove all the exited dockes
sudo docker ps -a | grep Exit | cut -d ' ' -f 1 | xargs sudo docker rm


# how-to run an image by image id
docker run -i -t fa2c3cede570 /bin/bash

# how-to stop an image by image-id
docker stop 50942fd04f50

# how-to copy a file to a running container 
docker cp -v /path/to/file 057230ffe0aa:/


# how-to commit container changes 
sudo docker commit CONTAINER_ID IMAGE_ID

msg="the commit msg"
container_id="cp-the container id to commit"
repo='298fd226fcbc40d0b2a3a39258abc/aspark-starter'
commit_tag='v4'
docker commit -m "$msg" -a "NAME" "$CONTAINER_ID" "$repo":"$commit_tag"


# how-to stop all the containers

# how-to remove all the images
