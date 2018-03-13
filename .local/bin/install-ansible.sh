install-ansible() {
 local pypkgs

 pypkgs='pip cryptography paramiko PyYAML simplejson passlib passlib[bcrypt]
         passlib[argon2] passlib[totp] fastpbkdf2 scrypt ansible'

 pip install --upgrade --user $pypkgs
}
