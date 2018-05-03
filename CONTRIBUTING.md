# Contributing

> **WARNING:** This guide is a work in progress and will continue to evolve over
> time. If you have content to contribute, please refer to this document
> each time as things may have changed since the last time you contributed.
>
> This warning will be removed once we have settled on a reasonable set of
> guidelines for contributions.

### 1 Verify your [remotes](https://git-scm.com/book/en/v2/Git-Basics-Working-with-Remotes)

To verify the new upstream repo you've specified for your fork, type
`git remote -v`. You should see the URL for your fork as `origin`, and the URL for the original repo as `upstream`.

```sh
origin  git@github.com:your-username/dotfiles.git (fetch)
origin  git@github.com:your-username/dotfiles.git (push)
upstream        https://github.com/ecwpz91/dotfiles (fetch)
upstream        no_push (push)
```

### 4 Modify your `develop`

Get your local `develop` [branch](https://git-scm.com/docs/git-branch), up to date:

```sh
git checkout develop
git fetch upstream
git merge upstream/develop
```

Then build your local `develop` branch, make changes, etc.

### 3 Keep your local clone in sync

```sh
git fetch upstream
git merge upstream/master
git merge upstream/develop
```

### 6 [Commit](https://git-scm.com/docs/git-commit) your `develop`

```sh
git commit
```

Likely you'll go back and edit, build, test, etc.

### 7 [Push](https://git-scm.com/docs/git-push) your `develop`

When ready to review (or just to establish an offsite backup of your work),
push your branch to your fork on `github.com`:

```sh
git push
```

### 8 Submit a [pull request](https://github.com/ecwpz91/dotfiles/compare/)

1. Visit your fork at https://github.com/your-username/dotfiles.git
2. Click the `Compare & Pull Request` button next to your `develop` branch.

At this point you're waiting on us. We may suggest some changes or improvements
or alternatives. We'll do our best to review and at least comment within 3
business days (often much sooner).

_If you have upstream write access_, please refrain from using the GitHub UI
for creating PRs, because GitHub will create the PR branch inside the main
repo rather than inside your fork.
