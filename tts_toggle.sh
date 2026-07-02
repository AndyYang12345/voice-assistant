#!/usr/bin/env bash
#
# voice-assistant — TTS 语音播报开关
# 用法:
#   tts_toggle.sh          # 切换开关
#   tts_toggle.sh on       # 开启
#   tts_toggle.sh off      # 关闭
#   tts_toggle.sh status   # 查看状态
#
TOGGLE_FILE="${HOME}/.tts_speak_enabled"

case "${1}" in
    on)
        touch "$TOGGLE_FILE"
        echo "✅ TTS 语音播报已开启"
        ;;
    off)
        rm -f "$TOGGLE_FILE"
        echo "🔇 TTS 语音播报已关闭"
        ;;
    status|"")
        if [[ -f "$TOGGLE_FILE" ]]; then
            echo "✅ TTS 语音播报: 开启"
        else
            echo "🔇 TTS 语音播报: 关闭"
        fi
        ;;
    *)
        echo "用法: tts_toggle.sh [on|off|status]"
        exit 1
        ;;
esac
