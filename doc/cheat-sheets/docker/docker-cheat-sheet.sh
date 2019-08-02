#file : docs/cheat-sheets/docker-cheat-sheet.sh


docker commit   -m "qto-181207010500 after db load" qto-container-01

# shutdown everything docker on macOs
killall com.docker.osx.hyperkit.linux
killall Docker && open /Applications/Docker.app # kill and and re-open it

# stop all the dockers
docker ps -q | xargs -L1 docker stop

# check the logs 
docker logs --tail 50 --follow qto-container-01

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

# how-to build a container by giving it the "container_name" from Dockerfile in the current dir
docker build -t container_name .

# how-to remove all the images 
docker rmi $(docker images | grep '^<none>' | awk '{print $3}')

# run an image into container
docker run qto_image -p 15432:15432

#how-to remove all containers
docker rm $(docker ps -a -q)

# delete all the images
docker rmi $(docker images -q)



Get the name or id of the image you would like to run, with this command: docker images

The docker run command is used in the following way:

docker run [OPTIONS] IMAGE [COMMAND] [ARG...]


docker run -d --name  qto-cotainer-01 -p localhost:15432:15432 --restart=always 

# how-to remove all the images

# information sources 
https://vsupalov.com/docker-build-pass-environment-variables/
