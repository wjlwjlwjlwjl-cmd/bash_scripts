# 一、变量

## 1.1 生命周期:

用户设置的普通变量，只在这个会话中有效。关闭终端模拟器窗口、`exit`、`reboot`、`poweroff`，都会失去这些变量（这是对于直接在命令行中定义的变量）

```shell
[wang@archlinux ~] myname="wang" 
[wang@archlinux ~] echo $myname
wang
```

这就是在命令行中定义变量的最简单方式。但是也有两点需要注意：

1. 变量赋值时，等号两边不能加空格（不要被其他语言的好习惯影响）
2. 使用变量时，不要忘记加上 `$`。Bash 通过 `$` 来区分出什么是变量

## 1.2 变量的在脚本中的定义方式

首先要对 Bash Scripts 和命令行的关系清楚：两者其实是一样的，你在 Bash Scripts 中写的命令，其实就是“持久化版本”的命令提示符后的命令

* 直接定义： `myname="wang"`
* 通过其他命令的输出结果来定义：`time=$(date)`，同样不只是命令变量，也可以通过 `echo "current time "$(date)` 的方式直接嵌入

## 1.3 变量命名规则的建议

在 Linux 中，存在 **环境变量** 这样的概念，包括 `$USER`、`$HOME` 等

环境变量都是由大写字母组成的，所以为了避免混淆，建议所有自己定义的变量都使用小写字母

## 1.4 Shell

常用的 shell 有很多，比如 Linux 常用的 Bash，Windows 的 PowerShell，MacOS 的 ZSH 等等。

shell 不同，命令就会有所不同。所以，为了表明当前脚本运行在什么 shell 中，我们一般在第一行进行标注，格式如下

```shell
#!/bin/bash
myname="wang"
echo $myname
```

# 二、Math

就像 Python 直接与解释器交互计算 `1 + 2` 一样，Bash 也可以，但是格式上有些许不同

* 加法：`expr 10 + 10`
* 减法：`expr 10 - 10`
* 除法：`expr 10 / 10`

乘法，有一些特殊，不能直接使用 `*`，需要使用 `\*`，例如 `expr 5 \* 5`。这里也需要注意，操作数和运算符之间要有空格

# 三、if 语句

`if-statement`，是我们迈向真正有用、好用的 Bash Script 的第一步。在 Bash Script 中，大体结果如下

```shell
val=100
if [ $val -eq 100 ]
then
  echo "val=100"
else
  echo "val!=100"
fi
```

**解释**
`if` 后面的中括号，其实是 `test` 命令，支持多种参数，比如：

* `-eq`，等于
* `-ne`，不等于
* `-gt`，大于
* `-lt`，小于

除了这些关系比较参数，`test` 还支持其他很多比较参数，比如`-f`，检查文件在后面指定的路径中是否存在

除了使用 `test` 命令，还有其他很多的命令可以使用，比如：`command`

```shell
command=nvim
if command -v $command
then
  nvim
else
  sudo pacman -S nvim
fi
```
查询当前系统中是否存在某个命令，最好的实践方式就是使用 `command` 命令，因为它会到系统环境变量查找，最后返回 路径 + 命令，比如 `command -v $command`，输出的结果就是（存在的话）`/usr/bin/nvim`

# 四、退出码

在我们的命令出现各种各样的错误后，在环境变量中会保存我们这一次错误的错误码（如果没有错误的话，就是0），可以使用 `echo $?` 查看。

在 Bash Script 中，也是相同。但是需要注意的是，退出码记录的是行为本身执行是否成功，而不是意义上的成功。

使用 `exit` 命令，退出 Bash Script，可以捎带退出码，例如 `exit 1`（这里的退出，类似于 C++ 的 `exit` 或者说 `abort`，不再往下执行代码

# 五、while 循环

通用格式：

```shell
cnt=1
while [ condition ]
do
  things to do
done
```

`condition` 和 `if-statement` 的条件使用方式相同，

# 六、for 循环

```shell
for val in conllection
do
  things to do
done
```

这里的 collection 是一个集合，可以是手动指定，比如 `1 2 3 4 5 6`，也可以是一个文件目录（集合元素就是该目录下的所有内容），例如

```shell
for file in /var/log
do
  tar -czvf $file.tar.zst $file
done
```

# 七、函数

```shell
check_exit_code(){
  if [ $(echo $?) -ne 0 ]
  then
    echo "error occured"
  fi
}
check_exit_code
```

## 7.1 参数定义方式

直接在函数内部通过 `$1` `$2` 即可定义变量，表示第一个变量、第二个变量等等

## 7.2 传参

Bash Script 中，传参不能使用括号，直接使用函数名 + 空格 + 参数（如果有参数的话）即可

## 7.3 返回值

返回值有两种方式：

1. 在函数中使用 `echo`，调用处通过 `$()` 的方式接收

2. 在函数中使用 `return`，外界使用 `echo $?` 的方式查看退出码（只能是 0 ～ 255 的状态值）

# 八、分支语句

```shell
#! /bin/bash
finish=0
while [ $finish -ne 1 ]
do
    echo "Choose a linux distribution you like"
    echo "1) Arch"
    echo "3) Debian"
    echo "4) Fedora"
    echo "6) exit the script"
    read option
    case $option in
    1) echo "Arch is rolling distribution";;
    3) echo "Debian is a stable, community distribution";;
    4) echo "Fedora is a distribution liked by Linus";;
    6) finish=1;;
    *) echo "Choice not good";;
    esac
done
echo "exit the script"
```

**注意点**

1. 分支语句每条情况最后要加上 `;;`
2. 条件判断通过 `条件值)` 的方式定义
3. 末尾加上 `esac` 表示语句结束

# 九、脚本的自动运行

## 9.1 at

`at` 是一个能够手动设定时间指定某个脚本合适运行的命令，语法格式大体如下

```shell
at 11:11 080226 -f test.sh
```

即表示 test.sh 脚本将在2026年八月二号执行

使用 `atq` 查看所有自动执行的任务；使用 `atrm` 删除自动执行的任务

## 9.2 crontab

crontab 在时间上做的比 at 要更好，但是也相对麻烦。使用 crontab -e 编辑 crontab 的配置文件，其中时间相关格式如下

```shell
# m h dom mon dow command
1 1 * * 2 /usr/local/bin/update.sh
```
参数意义从左到右依次为：分钟、小时、一个月中的第几天、哪个月、一周中的哪天、执行的命令。如果某一项不作为约束条件的话，使用 * 即可，上面的例子就是每周二的一点一分运行 `/usr/local/bin/update.sh`

# 十、参数

如果我们需要对某个脚本传参的话，那么其实我们可以把整个脚本理解成一个”大函数“，方式和函数的参数的使用是一样的。比如我们统计某个路径下文件的个数

```shell
#!/bin/bash
dir=$1
if [ $# -ne 1 ]
then
  echo "one argument required"
else
  echo $(ls -al $dir && wc -l)"files in the given directory"
fi
```

其中，`$#` 用来统计所有参数的个数