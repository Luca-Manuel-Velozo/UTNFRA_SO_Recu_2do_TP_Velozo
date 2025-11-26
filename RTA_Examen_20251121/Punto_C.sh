sudo usermod -aG docker LV
exit
su - LV
cd /UTN-FRA_SO_Examenes/202411/docker/web
sudo grep LV /etc/shadow | awk -F ':' '{print$2}'
sudo cat /etc/passw
sudo vim index.html
cat << FIN >> dockerfile
FROM nginx
COPY index.html /home/LV/UTN-FRA_SO_Examenes/202411/docker/web/index.html
FIN
docker login -u lucavelozo
docker build -t lucavelozo/web2-velozo:latest .
docker push lucavelozo/web2-velozo:latest
cd .. 
rm docker-compose.yml
cat << FIN >> docker-compose.yml
version: '3'

services:
    web:
      image: lucavelozo/web2-velozo:latest
      ports:
        - "81:80"
      volumes:
        - ./home/LV/UTN-FRA_SO_Examenes/202411/docker/web/file:/usr/share/nginx/html/file/
FIN
docker compose up -d

