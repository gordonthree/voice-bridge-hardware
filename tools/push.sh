#!/bin/bash
# Push main to github.com/gordonthree/voice-bridge-hardware using PAT_VOICE_BRIDGE from the env file. The token is never printed
# or written into git config: a throwaway credential helper reads it from the environment for this one command.
set -eu
cd "$(dirname "$0")/.."
set -a; . "$HOME/.config/voice-bridge/pat_voice_bridge.env"; set +a
[ -n "${PAT_VOICE_BRIDGE:-}" ] || { echo "PAT_VOICE_BRIDGE is empty or not set"; exit 1; }
URL=https://github.com/gordonthree/voice-bridge-hardware.git
git remote get-url origin >/dev/null 2>&1 || git remote add origin "$URL"
git remote set-url origin "$URL"
git -c credential.helper= -c 'credential.helper=!f() { echo username=gordonthree; echo "password=$PAT_VOICE_BRIDGE"; }; f' \
    push -u origin main --follow-tags 2>&1 | sed "s/$PAT_VOICE_BRIDGE/***/g"
echo "--- remote now:"; git remote -v
git status -sb | head -2
