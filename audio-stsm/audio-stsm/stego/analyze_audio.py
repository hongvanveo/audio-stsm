#!/usr/bin/env python3
import argparse
import math
import wave
from array import array


def read(path):
    with wave.open(path, "rb") as wav:
        params = wav.getparams()
        frames = wav.readframes(params.nframes)
    samples = array("h")
    samples.frombytes(frames)
    return params, samples


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--cover", required=True)
    parser.add_argument("--stego", required=True)
    args = parser.parse_args()
    p1, cover = read(args.cover)
    p2, stego = read(args.stego)
    if p1[:3] != p2[:3] or len(cover) != len(stego):
        raise SystemExit("audio files are not comparable")
    signal = sum(float(x) * x for x in cover)
    noise = sum(float(a - b) * (a - b) for a, b in zip(cover, stego))
    changed = sum(1 for a, b in zip(cover, stego) if a != b)
    snr = float("inf") if noise == 0 else 10 * math.log10(signal / noise)
    print(f"changed_samples={changed}")
    print(f"snr_db={snr:.2f}")


if __name__ == "__main__":
    main()

