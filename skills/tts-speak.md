---
name: tts-speak
description: 通过 voice-pipeline + GPT-SoVITS 将日语（或指定语言）文本合成为语音并自动播放。每次对话结束时自动播报摘要，权限询问时合成语音提问。
---

# TTS 语音播报技能

## 概述

调用 voice-pipeline 的 `tts_speak.py` 向 GPT-SoVITS API 发送合成请求，自动播放合成语音。

**前提条件：**
1. `voice-pipeline` 已安装（`tts-speak` 在 PATH 中）
2. GPT-SoVITS API 服务在运行（`tts-server`）

## 开关控制

```bash
# 开启语音播报
bash /path/to/voice-assistant/tts_toggle.sh on

# 关闭语音播报
bash /path/to/voice-assistant/tts_toggle.sh off
```

开关状态存储在 `~/.tts_speak_enabled` 文件中。

## 调用方法

```bash
# 基础调用（使用配置文件中的默认参考音频和提示文本）
tts-speak "合成したいテキスト" ja -q

# 指定不同参考音频
tts-speak "テキスト" ja -r "other_ref.wav" -p "対応するテキスト" -q

# 指定语言
tts-speak "你好世界" zh -q
```

## 使用场景

### 场景 1：响应后自动播报摘要

每次完成用户任务后：
1. 将完成的工作用 1~2 句简短总结
2. 调用 `tts-speak` 播报

### 场景 2：权限询问时合成语音

当需要向用户申请权限时：
1. 简短说明需要什么权限
2. 调用 `tts-speak` 播报，等待用户回应

### 场景 3：长任务进度通知

处理时间较长的任务时，中途播报进度。

## 行为规则

1. **仅在开关开启时播报**（检查 `~/.tts_speak_enabled` 是否存在）
2. **安静模式优先**：使用 `-q` 参数避免干扰终端输出
3. **简短短语**：摘要控制在 1~2 句，内容精炼
4. **非阻塞**：播报在后台运行，不打断工作流（使用 Bash `run_in_background: true`）

## 角色定制

本技能不内置任何角色设定。角色（语音风格、对话口吻、播报语言）由 `CLAUDE.md` 中的 TTS 配置段定义。

参见 `profiles/` 目录下的角色模板。
