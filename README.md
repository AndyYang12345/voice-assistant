# voice-assistant

**中文** | [**English**](README_EN.md)

[![Claude Code](https://img.shields.io/badge/Claude%20Code-skill-FF6C37?logo=anthropic&logoColor=white)](https://claude.ai/code)
[![Shell](https://img.shields.io/badge/Shell-bash-4EAA25?logo=gnu-bash&logoColor=white)](https://www.gnu.org/software/bash/)
[![Platform](https://img.shields.io/badge/platform-Linux%20|%20macOS-lightgrey)](https://github.com/AndyYang12345/voice-assistant)
[![License](https://img.shields.io/badge/license-MIT-blue)](LICENSE)
[![Depends](https://img.shields.io/badge/depends-voice--pipeline-8A2BE2)](https://github.com/AndyYang12345/voice-pipeline)

Claude Code 语音助手插件 —— 基于 [voice-pipeline](https://github.com/AndyYang12345/voice-pipeline) 的 Claude Code TTS 交互集成。

## 功能

- **tts-speak skill**: 定义 Claude Code 何时播报语音、如何调用 TTS 管线
- **角色模板**: 可定制的 CLAUDE.md 配置，支持不同角色/语言/风格
- **tts-toggle**: 语音播报开关

## 架构

```
voice-assistant (本仓库)     ← Claude Code 插件层（skill + 角色配置）
    │
    ├── skills/tts-speak.md  →  ~/.claude/skills/tts-speak.md
    ├── profiles/*           →  角色模板 → ~/.claude/CLAUDE.md
    └── tts_toggle.sh        →  ~/.local/bin/tts-toggle
         │
         ▼ 调用
voice-pipeline               ← TTS 管线层（合成 + 播放 + 服务管理）
    │
    ├── tts-speak            →  合成请求 + ffplay 播放
    ├── tts-config           →  配置管理
    ├── tts-server           →  API 服务管理
    └── GPT-SoVITS/          →  submodule: TTS 引擎
```

## 快速开始

### 前置依赖

- `voice-pipeline` 已安装（`tts-speak` 在 PATH 中可用）
- GPT-SoVITS API 服务运行中

### 安装

```bash
git clone https://github.com/AndyYang12345/voice-assistant.git
cd voice-assistant
bash install.sh
```

### 配置角色

将角色模板添加到 `~/.claude/CLAUDE.md`：

```bash
cat profiles/template.md >> ~/.claude/CLAUDE.md
# 然后编辑 ~/.claude/CLAUDE.md，填入你的角色信息
```

### 使用

```bash
tts-toggle on    # 开启语音播报
tts-toggle off   # 关闭语音播报
tts-toggle       # 查看状态
```

开启后，Claude Code 每次回复结束时会自动调用 voice-pipeline 播报日语语音摘要。

## 自定义角色

`profiles/template.md` 包含完整的 CLAUDE.md TTS 配置模板，你可以自定义：

- 角色名、来源作品
- 对话语言和 TTS 合成语言
- 模型路径和参考音频
- 播报场景和语气风格

## 许可证

MIT License — 参见 [LICENSE](LICENSE)
