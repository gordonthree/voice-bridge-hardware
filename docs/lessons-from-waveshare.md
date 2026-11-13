# Lessons from the Waveshare ESP32-S3-AUDIO-Board (hardware side only)

Source: `~/dev/voice-bridge-waveshare`, `docs/board-notes.md` and `README.md` (dated 2026-11-06 to 2026-11-09). Every number below was measured
there unless marked otherwise; the section titles of that file are given so a claim can be traced. The board's own facts (pins, codecs) are not
repeated: see that file.

## What the board is (one paragraph)

ESP32-S3R8 (8 MB PSRAM, 16 MB flash), ES7210 4-channel ADC with two microphones, ES8311 DAC into an NS4150B class-D amp and one small speaker,
TCA9555 expander, 7 WS2812 ring LEDs, PCF85063 RTC, SD slot, LCD/camera connectors, LiPo charger. USB is the S3's built-in USB-Serial/JTAG.

## What worked (so we keep it in a successor)

- Wi-Fi plus full-duplex audio plus PSRAM buffers fit with no trouble; the dev loop over USB works once the reset quirks are handled.
- The echo reference as a hardware channel: the ES7210 gives a loopback slot of the speaker output, time-aligned with the mics, which made the
  esp-sr echo canceller easy to feed. A successor needs this (a hardware loopback, or a clean software reference).
- A 16 kHz bus is enough ("sounds fine", listening test 2026-11-08) and removes all resampling.
- Echo cancellation reached 25 to 38 dB on the speaker's own voice, and a normal-volume barge-in works.

## Shortcomings (candidates for what better hardware should fix)

1. **The speaker is centimetres from the microphones, so her voice at the mics is as loud as, or louder than, the user's.**
   Echo at the mics sits 18 to 22 dB below the drive level; the user from 2 m is 11.5 dB quieter than from 45 cm. At the louder reply level
   (after the bridge's gain and limiter work) mic RMS from echo was 535 to 900 against the user's average of about 210 and loudest windows of about
   530. Talk-over therefore needs 20 to 25 dB of cancellation or more ("Distance check", "Echo probe", "16 kHz or 24 kHz bus?").
2. **Quiet barge-in does not work at high volume.** At volume 80 the echo doubled (mic RMS 1300 to 1700), the residual was about as loud as a
   soft voice, and a quiet interjection did not get through; volume 64 or lower helps ("M8 step 3"). The amp also distorts near the top of its
   range (community report: media volume clamped to 0.4 to 0.8).
3. **Two microphones earn nothing.** Averaging them gains 0.1 to 0.3 dB of SNR, because they are close together and the noise is common to
   both. There is no usable spatial information (no beamforming, no direction of arrival) ("One mic or two?", "Distance check").
4. **Far voices cannot be told from the user.** A repeating voice about 8 m away (a timer in another room) sat at RMS 80 to 90 on the cleaned
   stream for 44 minutes, against about 420 for Gordon at 2 m and a quiet floor of 3 to 8. With one effective mic the board cannot separate them,
   which is why **wake word and hands-free are parked** (README Status, 2026-11-09). Whether a real array, a different mic placement, or
   speaker-ID on the bridge is the fix is an open question, not a finding.
5. **Low signal at 2 m.** SNR 28.7 dB with 30 dB analog gain plus 2x soft gain; it transcribes fine, but there is little margin for a noisier
   room or a quieter talker.
6. **Tight internal RAM.** With the echo canceller held, about 50 to 57 KB of internal RAM is free (about 107 KB low point before it). The
   front end costs 14 to 29 KB internal, 164 to 172 KB PSRAM, plus roughly 33 KB static, and AEC + NS about 36% of one core (benchmark). It fits,
   but there is no headroom for a bigger model or on-device wake word ("M8 step 1").
7. **Power and time keeping are half-built.** The battery-voltage ADC pin needs a modification that disables the camera, so battery level is
   unavailable. The RTC's backup supercap pin is empty, so it loses the time at power-off. Only the chip's on-die temperature is reported.
8. **Documentation and openness.** Waveshare publishes no CAD files (KiCad, Altium, EasyEDA); the schematic PDF gives parts but not pin-to-net
   mapping, which had to come from the wiki and demo code. Waveshare's own demo warns that speech recognition cannot run while playing audio.
9. **Quirks that cost time, not capability.** Key press causes a 150 ms start-up burst on the mics; the default USB reset fails and needs
   `usb-reset` / `watchdog-reset`; one community report of audio failing at a cold start; LED colour order differs from what was documented.
10. **Not measured, so unknown:** CPU, heat and power draw with both codecs and the front end running all day; false-accept rate of wake word
    (no real model exists yet).

## Questions this raises for the requirements

- Is a **bigger acoustic separation** between speaker and mics the main fix (separate speaker, directional mics, a mic array with real spacing,
  a mic on a stalk), or is it a **better processing platform** (more RAM/CPU for a full front end, or an SBC)?
- Is it acceptable for the terminal to be **two parts** (a mic puck near the listener, a speaker elsewhere)?
- Does the platform need to run the front end and wake word **locally**, given the bridge currently does them on the server?
