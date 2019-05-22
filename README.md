# FixIDAPython

[![996.icu](https://img.shields.io/badge/link-996.icu-red.svg)](https://996.icu)  [![LICENSE](https://img.shields.io/badge/license-Anti%20996-blue.svg)](https://github.com/996icu/996.ICU/blob/master/LICENSE)

修复IDA加载IDAPython时出现的错误。

## 错误描述
  - [找不到指定模块] 和 [can't load file]
    这是因为IDAPython会在PATH环境变量中搜索Python27.dll，如果没找到这个dll，那么就会出现这个错误。

![avatar](https://github.com/CCint3/FixIDAPython/blob/master/IDAPython_Error01.png?raw=true)

  - [IDAPython: importing "site" failed]
    这是因为在注册表中找不到Python的注册表项。

![avatar](https://github.com/CCint3/FixIDAPython/blob/master/IDAPython_Error02.png?raw=true)

![avatar](https://github.com/CCint3/FixIDAPython/blob/master/IDAPython_Error03.png?raw=true)

## 解决方案
  1. 创建一个相对目录和一个工具目录
``` sh
> MD D:\.symlink
> MD D:\Tools
```

  2. 在虚拟机中安装最新版的Python2；这里以Python 2.7.16为例，安装完成后：

  - Python amd64 需要将C:\Windows\System32\Python27.dll剪切到Python的安装目录下

  - Python x86 需要将C:\Windows\SysWOW64\Python27.dll剪切到Python的安装目录下

  3. 将Python amd64 和 Python x86从虚拟机中复制到D:\Tools目录下，重命名为Python2.7.16_amd64 和 Python2.7.16

  4. 在D:\\.symlink中创建Python的符号链接
``` sh
> MKLINK \D \J D:\.symlink\IDAPython_amd64 D:\Tools\Python2.7.16_amd64
> MKLINK \D \J D:\.symlink\IDAPython D:\Tools\Python2.7.16
```

  5. 将ida.bat和ida64.bat放入IDA Pro 7.0目录中；将idaq.bat和idaq64.bat放入IDA Pro 6.8目录中

  6. 运行bat即可

## batch功能
  - 获取UAC权限，用于修改注册表。该代码来自魔方；
  - 向注册表中添加IDA所需要的Python路径；
  - 设置PATH环境变量为Python的安装目录；
  - 启动IDA；

## 注意事项
  - IDA Pro 7.0使用Python2 amd64
  - IDA Pro 6.8使用Python2 x86
