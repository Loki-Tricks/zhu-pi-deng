# 猪屁登 · Codex 动画宠物

一只圆润软萌、总带温暖笑容的奶油白小猪。这个仓库包含可直接安装的 Codex v2 动画宠物包，拥有 9 组标准动画和 16 个观察方向。

![猪屁登动画预览](preview.png)

## 一键安装

### Windows

打开 PowerShell，粘贴下面一行并回车：

```powershell
irm https://raw.githubusercontent.com/Loki-Tricks/zhu-pi-deng/main/install.ps1 | iex
```

安装完成后重启 Codex，在宠物菜单中选择“猪屁登”。

### macOS

打开“终端”，粘贴下面一行并回车：

```bash
curl -fsSL https://raw.githubusercontent.com/Loki-Tricks/zhu-pi-deng/main/install.sh | bash
```

安装完成后重启 Codex，在宠物菜单中选择“猪屁登”。

## 下载仓库后安装

1. 点击 GitHub 页面右上角的 **Code → Download ZIP**。
2. 解压 ZIP。
3. Windows 双击 `install.bat`；macOS 双击 `install.command`（若系统询问，选择“打开”）。
4. 重启 Codex。

安装器会把已有的同名宠物自动改名备份，不会直接删除旧文件。

## 手动安装

将 `pet.json` 和 `spritesheet.webp` 一起复制到：

```text
%USERPROFILE%\.codex\pets\zhu-pi-deng\
```

随后重启 Codex。

## 卸载

Windows 在仓库目录中运行：

```powershell
powershell -ExecutionPolicy Bypass -File .\uninstall.ps1
```

macOS 在仓库目录中运行：

```bash
bash uninstall.sh
```

卸载脚本采用可恢复方式移走文件，不会永久删除宠物包。

## 包信息

- 显示名称：猪屁登
- 包 ID：`zhu-pi-deng`
- 精灵版本：Codex v2
- 图集：`1536 × 2288` WebP，`8 × 11` 布局
- 单元格：`192 × 208`

## 说明

这是非官方的粉丝创作 Codex 宠物。安装脚本采用 MIT License；角色名称、形象及相关视觉资产的权利归其各自权利人所有。详见 [NOTICE.md](NOTICE.md)。
