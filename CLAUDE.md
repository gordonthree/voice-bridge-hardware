# voice-bridge-hardware

Project documentation lives in `README.md`: read its "Index" section first. This file is intentionally thin: Claude Code auto-loads
`CLAUDE.md` (not `README.md`). `README.md` is the single source of truth; don't duplicate it here. When you add a section or long note to
it, add a line to its Index in the same commit.

This repo is a **discussion and decision repo, not firmware**: what hardware a voice-bridge terminal should have. No code is expected until a
platform is chosen (then it gets its own firmware repo, as `voice-bridge-waveshare` did).

Sibling repos: `voice-bridge` (`~/dev/voice-bridge`; the bridge and the WebSocket protocol, the contract), `voice-bridge-waveshare`
(`~/dev/voice-bridge-waveshare`; the firmware for the board we have now, and the source of every measurement quoted here).

Keys: never read `~/.config/voice-bridge/*.env` (API keys and the GitHub token; a user-level deny rule enforces it). Commit new project files as
they are created; push only when asked (`tools/push.sh`, same token as the sibling repos, `PAT_VOICE_BRIDGE`; the token must be granted this repo too).
