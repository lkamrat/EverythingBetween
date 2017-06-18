docker run --name xlabweb --hostname xlabweb -m 1g -p 80:80 -P -i -t ubuntu /bin/bash
apt-get update -y
apt-get install nano apache2 -y
nano /var/www/html/index.html
service apache2 restart

Ctrl+P & Ctrl+Q

docker commit web

docker tag [OPTIONS] IMAGE[:TAG] [REGISTRYHOST/][USERNAME/]NAME[:TAG]

docker login xlabacr.azurecr.io -u xlabacr -p "Container Registry Access Key"

docker tag xlab/web xlabacr.azurecr.io/myimages/xlabweb
docker push xlabacr.azurecr.io/myimages/xlabweb