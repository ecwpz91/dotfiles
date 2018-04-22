# Dotfiles

A [dotfile](https://en.wikipedia.org/wiki/Dot-file) (plural dotfiles) is generally any file whose name begins with a full stop, or starts with a dot.

Commonly found on Unix-like systems, they provide user specific customization, and are analogous to [Batman's utility belt](https://en.wikipedia.org/wiki/Batman%27s_utility_belt).

To get started on Red Hat and CentOS (YUM), or Fedora (DNF) use the instructions below.

### Install Using Git

#### 1 Install [Extra Packages for Enterprise Linux (EPEL)](https://fedoraproject.org/wiki/EPEL)

#### 2 Install Git on Linux

Either via [Binary](https://git-scm.com/downloads), or [Package Manager](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git#_installing_on_linux) (preferred).

#### 3 [Create a GitHub account](https://github.com/join?source=header-home)

#### 4 [Connect to GitHub using SSH](https://help.github.com/articles/connecting-to-github-with-ssh/)

#### 5 Fork the `dotfiles` repo

Forking `dotfiles` is a simple two-step process.

1. On GitHub, navigate to the https://github.com/ecwpz91/dotfiles repo.
2. In the top-right corner of the page, click **Fork**.

That's it! Now, you have a [fork](https://help.github.com/articles/fork-a-repo/) of the original https://github.com/ecwpz91/dotfiles repo.

#### 6 Create a local clone of your fork

Right now, you have a fork of the `dotfiles` repo, but you don't have the files in that repo on your computer.

Let's create a [clone](https://git-scm.com/docs/git-clone) of your fork locally on your computer.

```sh
DIRPATH="${HOME}/github" \
&& GITUSER="ecwpz91" \
&& GITREPO="git@github.com:${GITUSER}/dotfiles.git" \
&& ARCHIVE="$(printf "%s" "${GITREPO##*/}")" \
&& mkdir -p "${DIRPATH}/${GITUSER}" \
&& pushd "${DIRPATH}/${GITUSER}" &>/dev/null \
&& git clone "${GITREPO}" \
&& popd  &>/dev/null \
&& unset DIRPATH GITUSER GITREPO ARCHIVE temp
```

### No git? No problem!

Open a new terminal to copy & paste the following, which will download and extract the repository into your local "Downloads" folder.

```sh
DIRPATH="${HOME}/Downloads/dotfiles" \
&& GITUSER="ecwpz91" \
&& GITREPO="https://github.com/${GITUSER}/dotfiles/archive/master.zip" \
&& ARCHIVE="$(printf "%s" "${GITREPO##*/}")" \
&& curl -LO "${GITREPO}" \
&& temp="$(mktemp -d)" \
&& unzip -d "${temp}" "${ARCHIVE}" \
&& mkdir -p "${DIRPATH}" \
&& mv "${temp}"/*/* "${DIRPATH}" \
&& rm -rf "${temp}" "${ARCHIVE}" \
&& unset DIRPATH GITUSER GITREPO ARCHIVE temp
```
