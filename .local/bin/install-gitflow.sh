install-gitflow() {
 sudo /bin/bash -c 'pushd /tmp &>/dev/null
                    wget --no-check-certificate -q  https://raw.githubusercontent.com/petervanderdoes/gitflow-avh/develop/contrib/gitflow-installer.sh
                    ./gitflow-installer.sh install stable
                    rm gitflow-installer.sh
                    popd &>/dev/null
 '
}
