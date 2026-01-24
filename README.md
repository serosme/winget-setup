# winget-setup

## 文档

[WinGet](https://learn.microsoft.com/zh-cn/windows/package-manager/winget/)

## 快速开始

导入

```shell
irm https://script.seros.me/restore-winget | iex
```

## 配置

代理

```shell
winget settings set DefaultProxy http://127.0.0.1:7890
```

## 命令

导出

```shell
winget export -o winget.json
```

导入

```shell
winget import -i .\winget.json
```
