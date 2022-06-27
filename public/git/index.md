# Git常用功能(github)


<!--more-->
## Git介绍
Git is a free and open source distributed version control system designed to handle everything from small to very large projects with speed and efficiency.
## Git常用命令
```
git init
git pull
git push
git add
git commit
git rebase
git cherry-pick
git submodule
git lfs
git clone
```

## Git常用命令简述

#### git init
- 说明：Create an empty Git repository or reinitialize an existing one
- git init -b <branck-name>

#### git pull
- 说明：Fetch from and integrate with another repository or a local branch


#### git push
- 说明：Update remote refs along with associated objects

#### git add
- 说明：Add file contents to the index

#### git commit
- 说明：Record changes to the repository


#### git rebase
- 说明：Reapply commits on top of another base tip

#### git cherry-pick
- 说明：Apply the changes introduced by some existing commits

#### git submodule
- 说明：Initialize, update or inspect submodules

#### git lfs
> git上传大文件
- 遇到的问题：一般git上传文件不会超过100M，当文件超过的时候会遇到下面问题
> remote: Resolving deltas: 100% (472/472), done.
> remote: error: GH001: Large files detected.
> You may want to try Git Large File Storage - https://git-lfs.github.com.

- 安装git-lfs 本机
    ```
    git lfs install
    ```
- 选择lfs管理的大文件(文件匹配支持通配符)
    ```
    git lfs track "the lage file's path"
    ```
- 添加.gitattributes文件
    ```
    git add .gitattributes
    ```
- git提交等操作
    ```
    git add xxx
    git commit -m "xxxx"
    git push origin main
    ```
#### git clone
- git clone -b branchname xxxxx

## Git常见问题
#### `the remote end hung up unexpectedly`
**Resolve**
- 问题原因：推送文件太大
- 解决：修改设置git config文件的postBuffer的大小（500MB）
    -- git config --global http.postBuffer 524288000


