Docker Backup
-------------

Create keypair:

```bash
openssl genrsa -out pass-protected-output-key.pem -aes256 4096 #generate keyfile
openssl rsa -in pass-protected-output-key.pem -out key.pem #optional remove passphrase from generated key
```

Encrypt directory:

```bash
tar -cf - directory_to_backup | openssl aes-128-cbc -pass file:certs/key.pem -salt -out backup.tar.aes
```

Decrypt directory:

```bash
openssl aes-128-cbc -pass file:certs/key.pem -d -salt -in backup.tar.aes | tar -x -f -
```
