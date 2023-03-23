install-drush() {
 curl -L 'https://github.com/drush-ops/drush/archive/refs/tags/11.0.7.tar.gz' \
 | tar --strip-components=1 -xvzf - drush-11.0.7/drush -C "$HOME/Downloads" &>/dev/null
}