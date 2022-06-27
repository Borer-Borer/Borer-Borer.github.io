# bash shell编写基础

![wp2618273-blackarch-wallpaper.jpg](https://cdn5.maocdn.cn/img/2021/06/15/wp2618273-blackarch-wallpaper.jpg)
## 一.基本语法：

*shell's power：可以轻便的调用其他程序并对它们的输出进行处理，因此可以用其编写出大量工具程序*

#### 1.$

> $0当前脚本名，$#总共参数个数，$*所有参数，$1,$2,$3...对应参数，$?上一次命令执行返回值
>

#### 2.test command:

> [<=====>test
>
> [ -option command ]:条件测试语句---0表示成功

#### 3.文件测试语句

> -d:文件是否为目录类型
> -e:文件是否存在
> -f:判断文件是否为一般文件
> -r:当前用户是否有权限读取
> -w，-x

#### 4.逻辑测试语句

> && || ! 逻辑运算符
>

#### 5.整数值比较

> eq ne gt lt le ge
>

#### 6.字符串比较

> = != -z -n

#### 7.条件语句

> if then fi
> if then else fi
> if then elif then else fi

#### 8.循环语句

> for do done
> while do done

#### 9.break&&continue

#### 10.case

> case in ) esac
>

#### 11.some commands

> $()<====>``:其结果是命令的字符串形式的输出不是命令的退出状态
> expr(调用新shell)<==-==>()
> .
> :
> echo
> eval
> exec
> exit n
> return
> export
> printf
> set
> shift
> trap
> unset
> xrags
> {}
> here文档--输入重定向--<< flag
> ..... 
> flag
>
> find [path] [options] [tests] [actions]
> grep [options] pattern [files]

#### 12.other basic

> ###### 用户身份:
>
> /etc/passwd
> 系统管理员：UID 0
> 系统用户：UID 1～999
> 普通用户：UID 1000开始
> useradd -d -e -u -g -G -N -s
> groupadd
> usermod -c -d -m -e -g -G -L -U -s -u
> passwd
> userdel -f -r
>
> ###### 文件权限:
>
> +,-
> filetype:
> -:普通文件
> d:目录文件
> l:链接文件
> d:块设备文件
> c:字符设备文件
> p:管道文件
> SUID SGID SBIT
> chmod设置文件/目录权限
> chown设置文件/目录所有者所属组
> chattr设置文件/目录其他隐藏权限属性
> lsattr查看文件隐藏权限属性
> setfacl管理文件ACL规则
> getfacl显示文件的acl信息
>
> ###### su:
>
> su - username `-`环境变量等也进行切换
>
> ###### sudo：
>
> 特定命令执行权限给予指定用户
>
> visudo
>
> /etc/fstab
> mount
> unmount
>
> fdisk :分区管理
> mkfs:格式化
> du:查看文件占用空间大小
>
> ln -s -f -i -v
>

## Continuously updated....
startup files() Some of the files are read only when a shell is a login shell
     • /etc/profile. Executed automatically at login.
     • The first file found from this list: ~/.bash_profile,
       ~/.bash_login, or ~/.profile. Executed automatically at
       login.
     • ~/.bashrc is read by every nonlogin shell. However, if
       invoked as sh, or with --posix, Bash instead reads $ENV,
       for POSIX compatibility.
When an interactive login shell exits, or when non-interactive
login shell executes the exit built-in command, Bash reads
and executes ~/.bash_logout if that file exists. (A login shell is
one where the -l option is set.)



