# https://stackoverflow.com/questions/25805200/update-user-installed-packages-with-pip

import os
import pip
import subprocess

homedir = os.getenv('HOME')
homepkg = []

for dist in pip.get_installed_distributions():
    if not dist.location.startswith(homedir):
        continue
    homepkg.append(dist.project_name)

if len(homepkg) == 0:
    print('No locally-installed packages, nothing to update.')
    raise SystemExit

# --no-deps is required because --upgrade by default is recursive and would try
# to update packages that are not from homedir (e.g. from /usr).

subprocess.call(['pip', 'install', '--user', '--upgrade', '--no-deps'] + homepkg)
