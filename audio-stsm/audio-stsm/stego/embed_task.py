#!/usr/bin/env python3
import os
import subprocess
import sys


def mark(token):
    result = os.path.expanduser("~/.local/result/stsm_check.txt")
    os.makedirs(os.path.dirname(result), exist_ok=True)
    existing = ""
    if os.path.exists(result):
        with open(result, "r", encoding="utf-8") as handle:
            existing = handle.read()
    if token not in existing:
        with open(result, "a", encoding="utf-8") as handle:
            handle.write(token + "\n")


def get_inputs():
    # TODO: sua ten file audio goc ma em muon dung de nhung tin.
    input_audio = ""

    # TODO: sua ten file thong diep ma em tao truoc khi nhung tin.
    message_file = ""

    output_audio = "stego.wav"
    if not input_audio or not message_file:
        raise SystemExit("Hay mo embed_task.py va dien ten file audio va file message truoc khi chay.")
    return input_audio, message_file, output_audio


def main():
    input_audio, message_file, output_audio = get_inputs()
    if os.path.exists(message_file) and os.path.getsize(message_file) > 0:
        mark("PASS_MESSAGE_CREATED")
    cmd = [
        "python3",
        "stsm_stego.py",
        "embed",
        "--in",
        input_audio,
        "--out",
        output_audio,
        "--message",
        message_file,
    ]
    subprocess.run(cmd, check=True)
    print(f"Da nhung thong diep tu {message_file} vao {output_audio} su dung audio {input_audio}.")


if __name__ == "__main__":
    try:
        main()
    except subprocess.CalledProcessError as exc:
        sys.exit(exc.returncode)
