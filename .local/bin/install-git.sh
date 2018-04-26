install-git() {
 # sudo /bin/bash -c 'yum -y install curl-devel expat-devel asciidoc xmlto docbook2X
 #                    ln -s /usr/bin/db2x_docbook2texi /usr/bin/docbook2x-texi
 # '

 [[ ! -d ~/.local/share/git ]] && mkdir -p ~/.local/share/git

 curl -L 'https://mirrors.edge.kernel.org/pub/software/scm/git/git-2.17.0.tar.gz' \
 | tar -xzf - -C ~/.local/share/git --strip 1

 pushd ~/.local/share/git >/dev/null
 make prefix=~/.local all doc info
 make prefix=~/.local install install-doc install-html install-info

 # Alternatively you can use autoconf generated ./configure script to
 # set up install paths (via config.mak.autogen), so you can write instead
 # make configure
 # ./configure --prefix=~/.local
 # make all doc
 # make install install-doc install-html

 # If you're willing to trade off (much) longer build time for a later
 # faster git you can also do a profile feedback build with
 # make prefix=~/.local profile
 # make prefix=~/.local PROFILE=BUILD install

 # Or if you just want to install a profile-optimized version of git into
 # your home directory, you could run
 # make profile-install
 # make profile-fast-install
 popd >/dev/null
}
