init-firefox-quantum() {
 upgrade() {
  sudo bash -c '[[ "$(uname -m)" == "x86_64" ]] \
              && ost="$(uname)";ost="${ost,,}64" \
              && dir="/opt";app="firefox";ver="latest" \
              && uri="https://download.mozilla.org" \
              && src="$uri/?product=$app-$ver-ssl&os=$ost" \
              && curl -L "$src" | tar xfj - -C $dir \
              && unset ost app ver uri src dir
  '
 }

 desktop() {
  sudo bash -c 'OLD_DESKD="/usr/share/applications"
             OLD_DESKF="$OLD_DESKD/firefox.desktop"

             NEW_DESKD="/usr/share/applications"
             NEW_DESKF="$NEW_DESKD/firefox-quantum.desktop"

             EXEC_FIND="firefox";
             EXEC_REPL="\/opt\/firefox\/firefox"

             ICON_FIND="firefox";
             ICON_REPL="\/opt\/firefox\/browser\/icons\/mozicon128\.png"

             NAME_FIND="Firefox";
             NAME_REPL="Firefox Quantum"

             if [[ ! -f $NEW_DESKF ]]; then
              if [[ -f $OLD_DESKF ]]; then
               sed "s/Exec\=$EXEC_FIND/Exec\=$EXEC_REPL/g
                    s/Icon\=$ICON_FIND/Icon\=$ICON_REPL/g
                    s/$NAME_FIND/$NAME_REPL/g" $OLD_DESKF > $NEW_DESKF
              else
               cat <<EOF > $NEW_DESKF
[Desktop Entry]
Version=1.0
Name=Firefox Quantum Web Browser
Comment=Browse the Web
Exec=/opt/firefox/firefox %u
Icon=/opt/firefox/browser/icons/mozicon128.png
Terminal=false
Type=Application
Categories=Network;WebBrowser;
EOF
fi
fi
  '

  systemctl restart gdm.service

  # [NOTE] Keep in mind that restarting the service forcibly interrupts any
  # currently running GNOME session of any desktop user who is logged in. This
  # can result in users losing unsaved data.
 }

 main() {
  upgrade
 }

 main "${@}"
}
