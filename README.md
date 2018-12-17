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

安装完民后会生成```~/.yuprc```文件，该文件将先于oh-my-zsh载入，因此编辑此文件将可以覆盖ohmyzsh的部分配置。

### 添加扩展

yup主要用于管理你的脚本或是运维工具，所以其主要功能是由扩展来实现。LXTech团队提供了一个基础的通用扩展，你可以编辑```~/.yuprc```文件，在```_addons```数组中添加扩展的git地址。如下所示：

```bash
_addons=(
    https://github.com/LXTechnic/yup-tool.git
)
```

之后执行```yup update```更新扩展。

### 更新 Yup

yup更新有两种方式，一种是更新扩展，以及更新自身（以及扩展）。

更新扩展就如上文所述使用```yup update```即可。对yup自身的更新请使用```up-yup```指令，该指令同时会更新扩展。

### 基于远程 yuprc 构建 Yup 系统

为了方便企业部署，更新指令允许指定一个远程地址上的```.yuprc```范例文件，替换现有的```~/.yuprc```文件并更新，这样在安装完yup之后，执行以下范例指令即可完成shell环境构建：

```bash
yup update -u https://github.com/LXTechnic/public/blob/master/yuprc/general.zsh
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

用户可以根据自己的需要构建自己的Yup扩展。

> 以下内容待完善。
