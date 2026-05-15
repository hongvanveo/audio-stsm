#!/usr/bin/env python3
from pathlib import Path


WORKDIR = Path.home() / "stego"
RESULT = Path.home() / ".local" / "result" / "stsm_check.txt"


def main():
    RESULT.parent.mkdir(parents=True, exist_ok=True)
    tokens = []
    if (WORKDIR / "message.txt").is_file() and (WORKDIR / "message.txt").stat().st_size > 0:
        tokens.append("PASS_MESSAGE_CREATED")
    if (WORKDIR / "cover.wav").is_file() and (WORKDIR / "cover.wav").stat().st_size > 0:
        tokens.append("PASS_COVER_CREATED")
    if (WORKDIR / "stego.wav").is_file() and (WORKDIR / "stego.wav").stat().st_size > 0:
        tokens.append("PASS_STEGO_CREATED")
    if (WORKDIR / ".analysis_done").is_file() and (WORKDIR / ".analysis_done").stat().st_size > 0:
        tokens.append("PASS_SAMPLES_MODIFIED")
    RESULT.write_text("\n".join(tokens) + ("\n" if tokens else ""), encoding="utf-8")


if __name__ == "__main__":
    main()
