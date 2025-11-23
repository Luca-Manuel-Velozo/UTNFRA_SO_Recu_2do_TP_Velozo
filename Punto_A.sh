sudo fdisk -l
sudo fdisk /dev/sdc
n
p
1
enter
enter
t
8e
w
sudo fdisk /dev/sdd
n
p
1
enter
+512M
t
82
w
sudo pvcreate /dev/sdc1 
sudo pvcreate /dev/sdd1
sudo vgcreate vg_datos /dev/sdc1 
sudo vgcreate vg_temp /dev/sdd1
sudo pvs
sudo vgs
sudo lvcreate -L +5M vg_datos -n lv-docker
sudo lvcreate -L +1.5G vg_datos -n lv-multimedia
sudo lvcreate -l +100%FREE vg_temp -n lv_swap
sudo mkfs.ext4 /dev/mapper/vg_datos-lv--docker
sudo mkfs.ext4 /dev/mapper/vg_datos-lv--multimedia
sudo mkswap /dev/vg_temp/lv_swap
free -h
sudo swapon /dev/vg_temp/lv_swap
sudo mkdir /Multimedia/
sudo mount  /dev/mapper/vg_datos-lv--multimedia /Multimedia/
sudo mount /dev/mapper/vg_datos-lv--docker /var/lib/docker/
sudo su 
cat << FIN >> /etc/fstab 
/dev/mapper/vg_datos-lv--docker /var/lib/docker/ ext4 defaults 0 0
/dev/mapper/vg_datos-lv--multimedia /Multimedia/ ext4 defaults 0 0
/dev/vg_temp/lv_swap none swap sw 0 0
FIN
exit
sudo systemctl restart docker
sudo systemctl status docker
