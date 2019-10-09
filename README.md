# git-text

**git-text** can help you to avoid from committing non-text files to git repo.

> **git-text** 能够帮忙避免提交非文本文件到 git 仓库。

## How to use it

> ## 如何使用

1. get a new command "git text"

> 获取新命令“git text”

```bash
git config --global alias.text '!f() { set -ex ; hookfile=$(git rev-parse --show-toplevel)/.git/hooks/pre-commit ; curl -sSL https://raw.githubusercontent.com/wolfogre/git-text/master/pre-commit -o $hookfile ; chmod +x $hookfile ; }; f'
```

2. install hook for a git repo

> 为某个 git 仓库安装钩子

```bash
cd A_GIT_REPO_DIR
git text
```

## How it works

> ## 工作原理

When you run `git text`, it will download a git hook to `.git/hooks/pre-commit`, so that every time you commit files, the hook will use [file](http://man7.org/linux/man-pages/man1/file.1.html) command to determine file's [mime type](https://www.iana.org/assignments/media-types/media-types.xhtml), and refuse committing if there are some non-text files.

> 当你运行 `git text`，它会下载一个 git 钩子文件到 `.git/hooks/pre-commit`，这样每次你提交文件的时候，钩子会使用 [file](http://man7.org/linux/man-pages/man1/file.1.html) 命令来探测文件的 [mime 类型](https://www.iana.org/assignments/media-types/media-types.xhtml)，如果提交的文件中有非文本文件，提交会被终止。

## Try it!

> ## 试试吧！

1. get git-text

> 获取 git-text

```text
$ git config --global alias.text '!f() { set -ex ; hookfile=$(git rev-parse --show-toplevel)/.git/hooks/pre-commit ; curl -sSL https://raw.githubusercontent.com/wolfogre/git-text/master/pre-commit -o $hookfile ; chmod +x $hookfile ; }; f'
```

2. create a new repo to test

> 创建一个新的 git 仓库用了测试

```text
$ mkdir test-repo
$ cd test-repo/
$ git init
Initialized empty Git repository in /root/test-repo/.git/
```

3. install git hook for the repo

> 为这个仓库安装 git 钩子

```text
$ git text
++ git rev-parse --show-toplevel
+ hookfile=/root/test-repo/.git/hooks/pre-commit
+ curl -sSL https://raw.githubusercontent.com/wolfogre/git-text/master/pre-commit -o /root/test-repo/.git/hooks/pre-commit
+ chmod +x /root/test-repo/.git/hooks/pre-commit
```

4. test committing text files

> 尝试提交文本文件

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

> 尝试提交非文本文件

```text
$ gzip test-text-file
$ git add --all
$ git commit -m "test commit"
DELETE NON-TEXT FILES OR USE 'git commit -n':
test-text-file.gz: application/x-gzip
```

6. if you really want to commit it

> 如果你真的需要提交非文本文件

```text
$ git commit -n -m "force commit non-text"
[master 7c01515] force commit non-text
 2 files changed, 64 deletions(-)
 delete mode 100644 test-text-file
 create mode 100644 test-text-file.gz
```
