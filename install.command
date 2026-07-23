#!/usr/bin/env bash
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
bash "${SCRIPT_DIR}/install.sh"

echo
read -r -p "按回车键关闭窗口..." _
