ansible-galaxy-upgrade() {
 ansible-galaxy install -r $HOME/.ansible/roles/requirements.yml --force "$@"
}
