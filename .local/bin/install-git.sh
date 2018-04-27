install-git() {
 # [NOTE] Check for system packages and install (if needed)
 # yum -y install curl-devel expat-devel asciidoc xmlto docbook2X
 # ln -s /usr/bin/db2x_docbook2texi /usr/bin/docbook2x-texi

 [[ ! -d ~/.local/share/git ]] && mkdir -p ~/.local/share/git

 curl -L 'https://mirrors.edge.kernel.org/pub/software/scm/git/git-2.17.0.tar.gz' |
 tar -xzf - -C ~/.local/share/git --strip 1

 pushd ~/.local/share/git >/dev/null
 make prefix=~/.local all doc info
 make prefix=~/.local install install-doc install-html install-info
 popd >/dev/null
}
