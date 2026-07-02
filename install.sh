#!/usr/bin/env bash
#
# voice-assistant 安装脚本
# 将 skill 复制到 ~/.claude/skills/，安装 tts_toggle 到 ~/.local/bin/
#
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SKILLS_DIR="${HOME}/.claude/skills"
BIN_DIR="${HOME}/.local/bin"

echo "╔══════════════════════════════════════╗"
echo "║   voice-assistant — 安装向导         ║"
echo "╚══════════════════════════════════════╝"
echo ""

# ── 检查依赖 ──
echo "→ 检查依赖..."

if ! command -v tts-speak &>/dev/null; then
    echo "  ❌ tts-speak 未安装。请先安装 voice-pipeline:"
    echo "     https://github.com/<your-username>/voice-pipeline"
    exit 1
fi
echo "  ✅ tts-speak: $(which tts-speak)"

if ! command -v tts-server &>/dev/null; then
    echo "  ⚠️  tts-server 未安装（服务管理脚本）"
else
    echo "  ✅ tts-server: $(which tts-server)"
fi

# ── 安装 skill ──
echo ""
echo "→ 安装 Claude Code skill..."

mkdir -p "$SKILLS_DIR"

if [[ -f "${SKILLS_DIR}/tts-speak.md" ]]; then
    echo "  ⚠️  已存在 ${SKILLS_DIR}/tts-speak.md，覆盖？[y/N]"
    read -r answer
    if [[ "$answer" =~ ^[Yy]$ ]]; then
        cp "${SCRIPT_DIR}/skills/tts-speak.md" "${SKILLS_DIR}/tts-speak.md"
        echo "  ✅ 已覆盖"
    else
        echo "  ⏭️  跳过"
    fi
else
    cp "${SCRIPT_DIR}/skills/tts-speak.md" "${SKILLS_DIR}/tts-speak.md"
    echo "  ✅ tts-speak.md → ${SKILLS_DIR}/"
fi

# ── 安装 toggle ──
echo ""
echo "→ 安装 tts-toggle..."

mkdir -p "$BIN_DIR"

TOGGLE_DST="${BIN_DIR}/tts-toggle"
if [[ -L "$TOGGLE_DST" ]] || [[ -f "$TOGGLE_DST" ]]; then
    echo "  ⚠️  tts-toggle 已存在，跳过"
else
    ln -s "${SCRIPT_DIR}/tts_toggle.sh" "$TOGGLE_DST"
    chmod +x "${SCRIPT_DIR}/tts_toggle.sh"
    echo "  ✅ tts-toggle → ${TOGGLE_DST}"
fi

# ── 提示 CLAUDE.md ──
echo ""
echo "→ 角色配置..."

if grep -q "TTS 语音助手" "${HOME}/.claude/CLAUDE.md" 2>/dev/null; then
    echo "  ⚠️  CLAUDE.md 中已有 TTS 配置，跳过"
else
    echo "  💡 CLAUDE.md 模板已准备好:"
    echo "     ${SCRIPT_DIR}/profiles/template.md"
    echo ""
    echo "  将此模板内容添加到 ~/.claude/CLAUDE.md 并根据你的角色修改。"
    echo "  或查看 profiles/ 目录下的预设角色。"
fi

# ── PATH 检查 ──
if [[ ":$PATH:" != *":$BIN_DIR:"* ]]; then
    echo ""
    echo "  ⚠️  ${BIN_DIR} 不在 PATH 中。"
    echo "  请将以下行添加到 ~/.zshrc:"
    echo ""
    echo "    export PATH=\"${BIN_DIR}:\$PATH\""
fi

echo ""
echo "══════════════════════════════════════"
echo "  安装完成！"
echo ""
echo "  下一步:"
echo "    1. 将 profiles/template.md 内容添加到 ~/.claude/CLAUDE.md"
echo "    2. 根据你的角色自定义 CLAUDE.md 中的设定"
echo "    3. tts-toggle on   # 开启语音播报"
echo "    4. 重新打开 Claude Code 会话"
echo "══════════════════════════════════════"
