# liz-docker-lamp
set of files for building docker image with LAMP stack inside

Clone repository: git clone git@github.com:starliz/liz-docker-lamp.git

Build image: docker build -t liz/lamp .

Run docker container: docker run --rm -i -p 8080:80 -p 2222:22 liz/lamp

SSH: ssh -p 2222 root@localhost

Collect logs: for f in /var/log/apache2/*.log /var/log/mysql/error.log /etc/os-release /proc/uptime; do echo;echo "--- FILE: $f ----"; cat $f; done >/var/www/html/info.txt


