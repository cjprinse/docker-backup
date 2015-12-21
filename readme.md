# Docker Backup #


The Docker backup image creates a backup to a webdev location. It is possible to send an email afterward. (Work in progress)
The Backups are stored encrypted, so we don't need to worry about sensitive data in the backup.

Docker environment variables:
- GPG_PUBLIC_KEY: The filelocation for the GPG_PUBLIC KEY, Note that this key has to be for the `database` user
- BACKUP_DIRS: The directories to backup to the given archive name, seperated by space (ex. "/data/dir1:archive1 /data/dir2:archive2)
- BACKUP_MYSQL: The Databases that have to be backuped, seperated by space (ex. HOST:DATABASE:USER:PASSWORD:ARCHIVE HOST2:DATABASE2:USER2:PASSWORD2:ARCHIVE)
- WEBDAV_HOST: The host where to store the backup. This will be mounted as /mnt/backup
- WEBDAV_USER: The webdav user to login to storage
- WEBDAV_PASSWORD: The webdav password to login to storage
- SMTP_HUB: The SMTP hub to use. ex. smtp.gmail.com:465 (optional)
- SMTP_USER: The SMTP user to login (optional)
- SMTP_PASS: The SMTP password to login (optional)
- SMTP_DOMAIN: The SMTP domain, from where the email is send (optional)
- SMTP_HOSTNAME: The Hostname of the container, used for mail validation (optional)

## Encryption ##

As said, the backups are stored encrypted. We use gpg to encrypt the files. This can be done, only by providing a public RSA key

Use this command to create a gpg keypair. NB This should be done outside the container!!!

`gpg --gen-key`  
choose `(1) RSA and RSA (default)`  
choose keysize `4096`  
choose `0 = key does not expire`  
Real name: `backup`  
You can keep email and comment empty

### Export private key ###

`gpg --armor --export-secret-keys backup`

### Export public key ###

`gpg --armor --export backup`

### Import public key ###

`gpg --import /certs/public.gpg-key`

### Encrypt folder ###

`tar -zc /var/log | gpg --armor --trust-model always -e -r backup -o /certs/backup.tar.gz.gpg`

### Decrypt folder ###

`gpg -d -r backup backup.tar.gz.gpg | tar -zxvf -`
