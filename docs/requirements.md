# Requirements (draft, 2026-11-13; direction answers from Gordon added the same day, the rest still unreviewed)

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
- **[decided 2026-11-13]** Hands-free from across the room stays the goal, at **2 to 3 m at most**. Gordon has been reading about beamforming
  arrays (tracking a speaker, rejecting ambient noise better), so a real mic array with beamforming is the intended answer to shortcomings 3
  and 4 in `docs/lessons-from-waveshare.md`.

## Constraints

- **[ask]** Budget, build effort (buy a module / carrier board vs design a PCB), time to a working unit.
- **[decided 2026-11-13]** More audio processing moves **onto the terminal**: the front end (beamforming, echo cancellation, noise suppression)
  and possibly wake word, or at least a **local trigger** with the bridge still doing the real wake-word decision. The ESP32-S3 is good for
  the interface, but its memory is too small and it has no peripherals for audio beyond the I2S interfaces.
- **[decided 2026-11-13, proposed architecture, not yet validated]** Two processors: an **STM32H7** dedicated to the microphone array and audio
  processing, and an **ESP32-S3** for the user interface (keys, ring, Wi-Fi) and for streaming to and from the bridge. Open: the link
  between them (I2S/SAI for audio, SPI or UART for control), who owns the speaker and the echo reference, and the update path for two firmwares.
- **[known]** Privacy rule from the bridge: logs carry types and sizes, never conversation text.
