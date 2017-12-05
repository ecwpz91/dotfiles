#!/usr/bin/env bash

function chromium-pepflash() {
 dnf install ./flash-player-ppapi-26.0.0.151-release.x86_64.rpm -y
 ln -s /usr/lib/adobe-flashplugin/* /usr/lib64/chromium-browser/PepperFlash/
 PEPPER_FLASH_VERSION="$(grep '"version":' /usr/lib64/chromium-browser/PepperFlash/manifest.json | grep -Po '(?<=version": ")(?:\d|\.)*')"

 printf "Exec=/usr/bin/chromium-browser %U --ppapi-flash-path=/usr/lib64/chromium-browser/PepperFlash/libpepflashplayer.so --ppapi-flash-version=%s" "${PEPPER_FLASH_VERSION}"
}
