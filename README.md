# Yup Stack

Yup是一个Shell脚本管理工具，完全由Zsh写成，同时也会提供一些便捷脚本和Zsh库。按Yup规范构建自己的脚本或工具库，将可以方便地部署到你的服务器系统中，并随时更新。

## 开发计划

- [ ] 为Command增加代码提示

## 基本使用

### 安装 Yup

首先安装所需要的基础环境，这里以Ubuntu系统为例：

```bash
sudo apt install -y git zsh
```

Yup依赖于[Oh My Zsh](https://github.com/robbyrussell/oh-my-zsh)项目：

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
```

如果没有能修改默认shell请自行编辑```/etc/passwd```修改自己的默认shell然后重新登录。

zsh启动后安装yup：

```bash
zsh -c "$(curl -fsSL https://raw.githubusercontent.com/veeshan-io/yup/master/setup.zsh)"
```

### .yuprc

安装后会生成```~/.yuprc```文件，该文件将先于oh-my-zsh载入，因此编辑此文件将可以覆盖ohmyzsh的部分配置。

### 添加扩展

yup用于管理你的脚本或是运维工具，所以其大量功能是由扩展来实现。LXTech团队提供了一个基础的通用扩展，你可以编辑```~/.yuprc```文件，在```_addons```数组中添加扩展的git地址。如下所示：

```bash
_addons=(
  https://github.com/LXTechnic/yup-tool.git
)
```

之后执行```yup update```更新扩展。

### 更新 Yup

yup更新有两种方式，一种是更新扩展，以及更新自身（包括扩展）。

更新扩展就如上文所述使用```yup update```即可。对yup自身的更新请使用```up-yup```指令，该指令同时会更新扩展。

### 基于远程 yuprc 构建 Yup 系统

为了方便企业部署，更新指令允许指定一个远程地址上的```.yuprc```范例文件，替换现有的```~/.yuprc```文件并更新，这样在安装完yup之后，执行以下范例指令即可完成shell环境构建：

```bash
yup update -u https://raw.githubusercontent.com/veeshan-io/yup/master/example/yuprc.zsh
```

### 删除 Yup 或重新安装

重新安装Yup非常简单，只需要删除一些文件即可：

```bash
rm -rf ~/.yup
rm ~/.yuprc
```

## 关于 YLib

```YLib```是尝试对zsh的贡献，Yup以及yup-tool的很多可抽象功能都会在YLib中实现，该库完全可以脱离Yup执行，只是在Yup中会默认载入。

具体提供的功能，可[点击这里](https://github.com/veeshan-io/ylib)查看。

## Yup 扩展

用户可以根据自己的需要构建自己的Yup扩展，一个Yup扩展可能包括的文件如下所示：

```bash

.
├── init.zsh  # 初始化脚本
├── bin       # 可执行脚本
├── cmd       # 扩展指令
├── lib       # 库文件
└── pub       # 公共库文件

```

这是一个全量的Yup扩展目录结构，其中的每个元素都是可以省略的，可根据自己的需要省略。

### init.zsh

init.zsh是初始化脚本，该脚本会在yup系统中被优先自动执行。具体可以查看生成的```~/.yup/.autoload```文件了解其加载方式。

### bin 目录

bin目录下是独立的可执行脚本，放在该目录下的脚本在```update```时均会创建软链到```$PATH```目录下并设置```+x```执行权限方便调用。在软链过程中会去掉脚本后缀名，因此可以放心地使用```.zsh```为后缀编写脚本。

只要系统中有对应的解释器或是确保可执行，所以非zsh脚本都是可以支持的，比如py或是php之类的都没问题。

### cmd 目录

该目录下仅支持```.zsh```文件，所有在该目录下的文件均可以以```yup <filename>```的形式被调用，支持参数。调用时的指令名称不需要提供后缀名，但文件名必须以```.zsh```为后缀。

文件内置脚本必须放在与文件主名同名的函数中作为入口，例如文件名```oh-my-style.zsh```的入口结构必须是：

```bash

oh-my-style() {
  # your code..
}

```

### lib 目录

这里用于放置库文件，后缀名必须是```.zsh```，这里的代码在执行```yup```时会被先行执行一遍。

### pub 目录

这是公共库文件，后缀名必须是```.zsh```。与```lib```的区别是```pub```中的文件会被写入```~/.yup/.autoload```中自动载入，这样在shell可以直接调用。

## 实践策略

上面说的都是各个操作方法，具体实践中，大约会按以下步骤进行：

0. 开库，创建自己的Addon，把自己的常用脚本放进去
0. 创建自己的```.yuprc```，加入自己的插件地址。可以放到某个可访问到的地方（如果没有安全问题公网也行）
0. 走安装流程安装```Yup```
0. 执行```yup update -u <your-addon-url>```
0. 搞定

