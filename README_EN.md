# voice-assistant

[**中文**](README.md) | **English**

[![Claude Code](https://img.shields.io/badge/Claude%20Code-skill-FF6C37?logo=anthropic&logoColor=white)](https://claude.ai/code)
[![Shell](https://img.shields.io/badge/Shell-bash-4EAA25?logo=gnu-bash&logoColor=white)](https://www.gnu.org/software/bash/)
[![Platform](https://img.shields.io/badge/platform-Linux%20|%20macOS-lightgrey)](https://github.com/AndyYang12345/voice-assistant)
[![License](https://img.shields.io/badge/license-MIT-blue)](LICENSE)
[![Depends](https://img.shields.io/badge/depends-voice--pipeline-8A2BE2)](https://github.com/AndyYang12345/voice-pipeline)

Claude Code voice assistant plugin — TTS interaction integration for Claude Code, powered by [voice-pipeline](https://github.com/AndyYang12345/voice-pipeline).

## Features

- **tts-speak skill**: Defines when Claude Code should speak and how to invoke the TTS pipeline
- **Character templates**: Customizable CLAUDE.md profiles supporting different characters / languages / styles
- **tts-toggle**: Voice announcement on/off switch

## Architecture

```
voice-assistant (this repo)   ← Claude Code plugin layer (skill + character profiles)
    │
    ├── skills/tts-speak.md  →  ~/.claude/skills/tts-speak.md
    ├── profiles/*           →  character templates → ~/.claude/CLAUDE.md
    └── tts_toggle.sh        →  ~/.local/bin/tts-toggle
         │
         ▼ calls
voice-pipeline               ← TTS pipeline layer (synthesis + playback + server mgmt)
    │
    ├── tts-speak            →  synthesis request + ffplay playback
    ├── tts-config           →  config management
    ├── tts-server           →  API server lifecycle
    └── GPT-SoVITS/          →  submodule: TTS engine
```

## Quick Start

### Prerequisites

- `voice-pipeline` installed (`tts-speak` available in PATH)
- GPT-SoVITS API server running

### Installation

```bash
git clone https://github.com/AndyYang12345/voice-assistant.git
cd voice-assistant
bash install.sh
```

### Character Setup

Append a character template to `~/.claude/CLAUDE.md`:

```bash
cat profiles/template.md >> ~/.claude/CLAUDE.md
# Then edit ~/.claude/CLAUDE.md with your character details
```

### Usage

```bash
tts-toggle on    # Enable voice announcements
tts-toggle off   # Disable voice announcements
tts-toggle       # Check status
```

When enabled, Claude Code will automatically invoke voice-pipeline to speak a Japanese voice summary after each response.

## Custom Characters

`profiles/template.md` contains a complete CLAUDE.md TTS configuration template. You can customize:

- Character name and source work
- Conversation language and TTS synthesis language
- Model paths and reference audio
- Announcement scenarios and tone

## License

MIT License — see [LICENSE](LICENSE)
