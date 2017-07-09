
# Build your image

`docker build -t webapp .`

# Option 1: Run your Docker Containers (port mode)

```
docker run \
--name=webapp \
-p 8080:80 \
-dt \
 webapp
 ```

Access your website at `http://localhost:8080`

# Option 2: Run your Docker Containers (per-ip mode)

Before your run the following commands, make sure you have enabled experimental features of Docker. 

To enable experimental features of Docker for [macvlan](https://docs.docker.com/engine/userguide/networking/get-started-macvlan/) deployments of containers, enter the following commands on your ubuntu docker host:

```
echo '{"experimental": true}' > /etc/docker/daemon.json
service docker restart 	
```

## Set up your MacVlan network 

Enter in the following commands to set up your docker network on the same L2 subnet as your docker host sharing the hosts' network interface for bridging packets across the underlay. 

>Replace network values (172.16.10.X) and network interface label (eth1) for your own L2 subnet and its interface that the docker host resides on. 

```
docker network create -d macvlan \
--subnet=172.16.10.0/24 \
--ip-range=172.16.10.128/25 \
--gateway=172.16.10.1 \
-o parent=eth1 MACv-Net
```

## Run the container with static IP

docker run \
--name=webapp \
--net=MACv-Net \
--ip=172.16.10.199 \
-dt \
 webapp

For example, access your website at `http://172.16.10.199`

>Remember to replace with your IP address when testing. 
