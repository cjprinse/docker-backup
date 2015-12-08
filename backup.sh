
echo $WEBDAV_HOST $WEBDAV_USER $WEBDAV_PASSWORD > /etc/davfs2/secrets
echo $WEBDAV_HOST" /mnt/backup davfs user,rw,auto 0 0" > /etc/fstab

mount /mnt/backup

mkdir -p /mnt/backup/now/registry

echo "blaat"


#umount /mnt/backup
