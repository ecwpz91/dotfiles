# Written by Lee bigelow <ligelowbee@yahoo.com>
#
# Pure shell script to find dead symlinks and output them quoted so they can
# be fed to xargs and dealt with.

function broken-links() {
 set +e

 # Check the directory for files that are links and don't exist.
 for element in $1/*; do
  [ -h "${element:-}" -a ! -e "${element:-}" ] && printf "%s\n" "${element:-}"
  [ -d "${element:-}" ] && chk-symlinks ${element:-}
  # Of course, '-h' tests for symbolic link, '-d' for directory.
 done

 set -e
}
