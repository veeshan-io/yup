# Yup Stack

Yup是一个Shell脚本管理工具，同时也会提供一些便捷脚本和Zsh库。

## 开发计划

- [ ] 为Command增加代码提示

## 安装 Yup

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

## .yuprc

安装完民后会生成```~/.yuprc```文件，该文件将先于oh-my-zsh载入，因此编辑此文件将可以覆盖ohmyzsh的部分配置。

你可以在