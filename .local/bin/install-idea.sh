install-idea() {
 [[ ! -d ~/.local/share/idea ]] && mkdir -p ~/.local/share/idea

 curl -L 'https://download.jetbrains.com/idea/ideaIU-2018.1.2-no-jdk.tar.gz' \
 | tar -xzf - -C ~/.local/share/idea --strip 1

 ln -s ~/.local/share/idea/bin/idea.sh ~/.local/bin/idea
}
