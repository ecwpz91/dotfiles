#!/usr/bin/env bash
function install-packer() {
 [[ "$(uname -m)" == "x86_64" ]] \
 && ost="$(uname)";ost="${ost,,}_amd64" \
 && app='packer' \
 && ver='1.1.1' \
 && ext='zip' \
 && arc="$app"'_'"$ver"'_'"$ost.$ext" \
 && sha="$app"'_'"$ver"'_SHA256SUMS' \
 && uri="https://releases.hashicorp.com" \
 && url="$uri/$app/$ver" \
 && src="$url/$arc" \
 && sig="$url/$sha" \
 && dir="$HOME/.local/bin" \
 && arg="out.$ext" \
 && tmp="$(mktemp -d)" \
 && wget $src \
 && wget $sig \
 && echo "$(cat $sha | grep -o ".*$ost.*")" > $sha \
 && sha256sum -c $sha \
 && unzip -d $tmp $arg \
 && cp -rf $tmp/* $dir \
 && rm -rf $tmp $arg $sha \
 && unset ost app ver ext arc uri url src dir sig dir arg tmp
}
