@echo off
chcp 65001 >nul
title 安装猪屁登 Codex 宠物
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0install.ps1"
if errorlevel 1 (
  echo.
  echo 安装失败，请把上面的错误信息提交到 GitHub Issues。
)
echo.
pause
