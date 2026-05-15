#!/bin/bash
: <<'END'
Pregrade script for STSM audio steganography.
It writes normalized check results to .local/result/stsm_check.txt.
END

homedir=$1
destdir=$2
dbg=/tmp/audio-stsm-pregrade.log

workdir="$homedir/$destdir/stego"
resultdir="$homedir/$destdir/.local/result"
result="$resultdir/stsm_check.txt"

mkdir -p "$resultdir"
: > "$result"
echo "pregrade for $homedir/$destdir" > "$dbg"

pass() { echo "PASS_$1" >> "$result"; }
fail() { echo "FAIL_$1: $2" >> "$result"; }

if [ -s "$workdir/cover.wav" ]; then
    pass "COVER_CREATED"
else
    fail "COVER_CREATED" "cover.wav missing"
fi

if [ -s "$workdir/stego.wav" ] && [ -s "$workdir/cover.wav" ]; then
    pass "STEGO_CREATED"
else
    fail "STEGO_CREATED" "stego.wav or cover.wav missing"
fi

if [ -s "$workdir/cover.wav" ] && [ -s "$workdir/stego.wav" ]; then
    cmp -s "$workdir/cover.wav" "$workdir/stego.wav"
    if [ $? -ne 0 ]; then
        pass "SAMPLES_MODIFIED"
    else
        fail "SAMPLES_MODIFIED" "cover and stego are identical"
    fi
else
    fail "SAMPLES_MODIFIED" "cannot compare audio files"
fi
