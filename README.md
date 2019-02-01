# git-text

**git-text** can help you to avoid from committing non-text files to git repo.

## How to use it

1. get a new command "git text"

```bash
git config --global alias.text '!gi() { curl -sSL https://raw.githubusercontent.com/wolfogre/git-text/master/pre-commit -o .git/hooks/pre-commit && chmod +x .git/hooks/pre-commit ; }; gi'
```

2. install hook for a git repo

```bash
cd A_GIT_REPO_DIR
git text
```

## How it works

When you run `get text`, it will download a git hook to `.git/hooks/pre-commit`, so that every time you commit files, the hook will use [file](http://man7.org/linux/man-pages/man1/file.1.html) command to determine file's [mime type](https://www.iana.org/assignments/media-types/media-types.xhtml), and refuse committing if there are some non-text files.

## Test it!

1. get git-text

```text
$ git config --global alias.text '!gi() { curl -sSL https://raw.githubusercontent.com/wolfogre/git-text/master/pre-commit -o .git/hooks/pre-commit && chmod +x .git/hooks/pre-commit ; }; gi'
```

2. create a new repo to test

```text
$ mkdir test-repo
$ cd test-repo/
$ git init
Initialized empty Git repository in /root/test-repo/.git/
```

3. install git hook for the repo

```text
$ git text
$ ls -l .git/hooks/pre-commit
-rwxr-xr-x. 1 root root 486 Jan 31 16:41 .git/hooks/pre-commit
```

4. test committing text files

```text
$ touch test-empty-file
$ echo ok > test-text-file
$ git add --all
$ git commit -m "test commit"
ALL FILES ARE TEXT:
test-empty-file: inode/x-empty
test-text-file:  text/plain
[master (root-commit) f17008d] test commit
 2 files changed, 1 insertion(+)
 create mode 100644 test-empty-file
 create mode 100644 test-text-file
```

5. test committing non-text files

```text
$ gzip test-text-file
$ git add --all
$ git commit -m "test commit"
DELETE NON-TEXT FILES OR USE 'git commit -n':
test-text-file.gz: application/x-gzip
```

6. if you really want to commit it

```text
$ git commit -n -m "force commit non-text"
[master 7c01515] force commit non-text
 2 files changed, 64 deletions(-)
 delete mode 100644 test-text-file
 create mode 100644 test-text-file.gz
```
