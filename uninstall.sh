#!/usr/bin/env bash
set -euo pipefail

DESTINATION="${HOME}/.codex/pets/zhu-pi-deng"

if [[ ! -e "${DESTINATION}" ]]; then
  echo "猪屁登尚未安装。"
  exit 0
fi

REMOVED="${DESTINATION}.removed-$(date +%Y%m%d-%H%M%S)"
mv "${DESTINATION}" "${REMOVED}"
echo "猪屁登已从 Codex 移除。"
echo "文件已保留在：${REMOVED}"
echo "重启 Codex 后生效。"
