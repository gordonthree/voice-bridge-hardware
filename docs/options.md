# Candidate hardware and decision log

Direction (Gordon, 2026-11-13): an STM32H7 for the mic array and audio processing plus an ESP32-S3 for the interface and streaming. Candidates to look at once the requirements are settled; add one section per candidate with what it fixes from
`docs/lessons-from-waveshare.md` (by number) and what it costs. Nothing below has been researched yet; these are names that came up, not
recommendations.

- A different ESP32-S3 board with a proper far-field mic array and a separate speaker (the esp-sr project documents some reference designs).
- The M5Stack STM32 + ESP32 hardware (the idea mentioned in the Waveshare README).
- A Raspberry Pi class SBC with a mic array HAT and a speaker (can run the front end and wake word locally).
- A purchased smart-speaker or conference-speakerphone platform used as a USB audio device.

## Questions for the STM32H7 + ESP32-S3 direction (not yet researched)

- How many mics, what geometry (linear, circular), which type (digital PDM/MEMS vs I2S/TDM codec), and does the H7 have the interfaces for it
  (SAI, DFSDM for PDM)? 2 to 3 m range sets the aperture.
- Beamforming, echo cancellation and noise suppression on a Cortex-M7: which libraries exist (CMSIS-DSP, vendor audio middleware, open-source AEC
  such as speexdsp/WebRTC), and what do they cost in CPU and RAM at 16 kHz?
- Local wake word or trigger on the H7 (a small keyword spotter) versus the bridge's detector: what false-accept rate is needed given the "far
  voice" problem (`docs/lessons-from-waveshare.md`, shortcoming 4)?
- Does the speaker's DAC/amp hang off the H7 (so the echo reference is exact, in one clock domain) or off the ESP32-S3?
- Prototype path: an STM32H7 dev board plus a mic-array board, or a custom PCB; what exists off the shelf?
