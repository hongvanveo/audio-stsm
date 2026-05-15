#!/usr/bin/env python3
from types import SimpleNamespace
import os
import sys

import stsm_stego


# TODO: Dien ten file audio goc, vi du: "cover.wav"
AUDIO_FILENAME = ""

# TODO: Dien ten file thong diep, vi du: "message.txt"
MESSAGE_FILENAME = ""

OUTPUT_FILENAME = "stego.wav"


def require_file(path, label):
    if not path.strip():
        raise ValueError(f"{label} is empty")
    if not os.path.isfile(path):
        raise FileNotFoundError(f"{label} not found: {path}")


def main():
    require_file(AUDIO_FILENAME, "audio filename")
    require_file(MESSAGE_FILENAME, "message filename")
    args = SimpleNamespace(infile=AUDIO_FILENAME, out=OUTPUT_FILENAME, message=MESSAGE_FILENAME)
    stsm_stego.embed(args)


if __name__ == "__main__":
    try:
        main()
    except Exception as exc:
        print(f"error: {exc}", file=sys.stderr)
        sys.exit(1)
