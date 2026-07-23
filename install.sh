#!/usr/bin/env bash
set -euo pipefail

PET_ID="zhu-pi-deng"
REPO_BASE="https://raw.githubusercontent.com/Loki-Tricks/zhu-pi-deng/main"
DESTINATION="${ZHU_PI_DENG_DESTINATION:-${HOME}/.codex/pets/${PET_ID}}"
TEMPORARY="$(mktemp -d "${TMPDIR:-/tmp}/zhu-pi-deng.XXXXXX")"

if [[ "${1:-}" == "--destination" ]]; then
  if [[ -z "${2:-}" ]]; then
    echo "错误：--destination 需要一个目录。" >&2
    exit 2
  fi
  DESTINATION="$2"
  shift 2
fi

if [[ "$#" -ne 0 ]]; then
  echo "用法：bash install.sh [--destination 目录]" >&2
  exit 2
fi

cleanup() {
  rm -rf -- "${TEMPORARY}"
}
trap cleanup EXIT

SCRIPT_DIR=""
if [[ -n "${BASH_SOURCE[0]:-}" && -f "${BASH_SOURCE[0]}" ]]; then
  SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
fi

if [[ -n "${SCRIPT_DIR}" && -f "${SCRIPT_DIR}/pet.json" && -f "${SCRIPT_DIR}/spritesheet.webp" ]]; then
  cp "${SCRIPT_DIR}/pet.json" "${TEMPORARY}/pet.json"
  cp "${SCRIPT_DIR}/spritesheet.webp" "${TEMPORARY}/spritesheet.webp"
else
  echo "正在从 GitHub 下载猪屁登..."
  curl -fL --retry 3 "${REPO_BASE}/pet.json" -o "${TEMPORARY}/pet.json"
  curl -fL --retry 3 "${REPO_BASE}/spritesheet.webp" -o "${TEMPORARY}/spritesheet.webp"
fi

if ! grep -Eq '"id"[[:space:]]*:[[:space:]]*"zhu-pi-deng"' "${TEMPORARY}/pet.json"; then
  echo "错误：pet.json 的 id 不正确。" >&2
  exit 1
fi

if ! grep -Eq '"spriteVersionNumber"[[:space:]]*:[[:space:]]*2' "${TEMPORARY}/pet.json"; then
  echo "错误：猪屁登不是 Codex v2 宠物包。" >&2
  exit 1
fi

SHEET_SIZE="$(wc -c < "${TEMPORARY}/spritesheet.webp" | tr -d ' ')"
if [[ "${SHEET_SIZE}" -lt 100000 ]]; then
  echo "错误：spritesheet.webp 下载不完整。" >&2
  exit 1
fi

if [[ -e "${DESTINATION}" ]]; then
  BACKUP="${DESTINATION}.backup-$(date +%Y%m%d-%H%M%S)"
  mv "${DESTINATION}" "${BACKUP}"
  echo "旧版本已备份到：${BACKUP}"
fi

mkdir -p "${DESTINATION}"
cp "${TEMPORARY}/pet.json" "${DESTINATION}/pet.json"
cp "${TEMPORARY}/spritesheet.webp" "${DESTINATION}/spritesheet.webp"

echo
echo "猪屁登安装成功！"
echo "安装位置：${DESTINATION}"
echo "请重启 Codex，然后在宠物菜单中选择“猪屁登”。"
