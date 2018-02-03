cmdcom() {
 local cmd=$1; shift || return 1

 [ -d ~/.profile.d ] \
 && rm -rf "$HOME/.profile.d/$cmd-completion" &>/dev/null \
 && $cmd completion bash > "$HOME/.profile.d/$cmd-completion"
}
