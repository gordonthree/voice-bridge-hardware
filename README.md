# voice-bridge-hardware

What proper hardware for a `voice-bridge` voice terminal should look like. Started 2026-11-13, split off from `voice-bridge-waveshare`
(the firmware for the Waveshare ESP32-S3-AUDIO-Board, our first terminal). That board does a lot, but it has hit hardware limits that keep it
from working the way Gordon envisioned, and the vision itself is changing as the project develops. This repo holds the discussion: goals,
capabilities, shortcomings, candidate platforms, decisions. It holds no firmware.

**The contract with the bridge is its WebSocket protocol** (source of truth: the `voice-bridge` README, section "Bridge", and the docstring of
`bridge/server.py`). Do not copy it here. A hardware choice must be able to speak it.

## Index (read this first)

Keep each entry to one line; when you add a section or a long dated note, add a line here in the same commit.

- **What the terminal must do (goals, room, personas, what is still undecided), to be settled with Gordon:** `docs/requirements.md`.
- **What the Waveshare board taught us, hardware only (acoustics, echo, mics, RAM, power, board quirks), with the measurements and where they came from:** `docs/lessons-from-waveshare.md`.
- **Candidate hardware and the decision log:** `docs/options.md` (empty so far).

## Status

- 2026-11-13: direction set by Gordon: hands-free at 2 to 3 m with a beamforming mic array; audio processing (and possibly a local wake trigger) on the terminal; proposed split of an STM32H7 (array and audio) plus an ESP32-S3 (interface and streaming). Candidates not yet researched (`docs/options.md`).
- 2026-11-13: repo created. Requirements are a first draft from the Waveshare project's notes; Gordon has not reviewed them. No candidate
  platform has been looked at yet.
