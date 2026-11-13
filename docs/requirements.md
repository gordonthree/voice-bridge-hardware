# Requirements (first draft, 2026-11-13; from the Waveshare project's notes, NOT yet reviewed by Gordon)

Items marked **[known]** come from the Waveshare project's README and notes. Items marked **[ask]** are questions for Gordon: the vision is
changing, so these are the first thing to settle.

## Where and how it is used

- **[known]** Sits on a coffee table; the listener is about 2 m away on a couch, sometimes with quiet music on.
- **[known]** Home Wi-Fi, no battery requirement stated, but a LiPo was fitted on 2026-11-08 (the board is now battery-backed).
- **[ask]** One terminal, or several rooms? A terminal is the only voice interface to the personas, or one of several?
- **[ask]** Always-on and mains powered, or portable?
- **[ask]** Does it need a display or camera, or is the light ring (or nothing) enough?

## What it must do

- **[known]** Speak the bridge's WebSocket protocol: 16 kHz mono PCM16 both ways (the bus was moved to 16 kHz on 2026-11-08), personas Mara and
  Hannah (switching, per-persona colours), notices (waiting messages), stats/log/event frames while idle, quiet hours (the bridge owns the clock).
- **[known]** Push-to-talk, then hands-free conversation, with **barge-in**: she can be interrupted by a normal or quiet voice while she speaks.
- **[known]** Remote wake word (the bridge detects it; the board streams a cleaned mic all the time). Currently **parked**: see
  `docs/lessons-from-waveshare.md`, "Far voices".
- **[known]** Physical controls: hold-to-talk, volume up/down, mute, persona switch, "I am finished".
- **[known]** A visible state (the ring: listening, thinking, speaking, message waiting, muted, offline, error).
- **[ask]** Speaker identity: should the terminal (or the bridge) know it is Gordon talking, and not a distant TV, timer or other person?
- **[ask]** Which of these is the real goal now: hands-free from across the room, near-field push-to-talk, something else?

## Constraints

- **[ask]** Budget, build effort (buy a module / carrier board vs design a PCB), time to a working unit.
- **[ask]** Tolerance for tinkering: another ESP32-S3 board, an SBC (Raspberry Pi class, which could run the front end and even wake word
  locally), a purchased smart-speaker platform?
- **[known]** Privacy rule from the bridge: logs carry types and sizes, never conversation text.
