# Create the DCOS configuration YAML file on the Bootstrap node
mkdir genconf
nano genconf/config.yaml

cat > genconf/config.yaml << '__EOF__'
bootstrap_url: http://xlab-dcos-bootstrap:80
cluster_name: xLab-DCOS-Cls
exhibitor_storage_backend: static
ip_detect_filename: /genconf/ip-detect
master_discovery: static
master_list:
- 192.168.0.160
- 192.168.0.161
- 192.168.0.162
resolvers:
- 8.8.4.4
- 8.8.8.8
- 192.168.0.100
__EOF__

# Create the DCOS ip-detect file on the Bootstrap node

cat > genconf/ip-detect << '__EOF__'
#!/usr/bin/env bash
set -o nounset -o errexit
export PATH=/usr/sbin:/usr/bin:$PATH
echo $(ip addr show ens192 | grep -Eo '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | head -1)
__EOF__
 
chmod 755 genconf/ip-detect

# To run on the Bootstrap node
curl -O https://downloads.dcos.io/dcos/stable/dcos_generate_config.sh
bash dcos_generate_config.sh

#The docker command start nginx docker container and serves up installer for other machines on your network
docker run -d -p 80:80 -v $PWD/genconf/serve:/usr/share/nginx/html:ro nginx

# To set up a Master
ssh root@xLab-DCOS-Master-03
curl -O http://xlab-dcos-bootstrap:80/dcos_install.sh
bash dcos_install.sh master

# To set up Private Agent
ssh root@xLab-DCOS-Private-Agent-03
curl -O http://xlab-dcos-bootstrap:80/dcos_install.sh
bash dcos_install.sh slave