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

if [ -f "$workdir/stsm_stego.py" ] && [ -s "$workdir/stego.wav" ]; then
    (cd "$workdir" && python3 stsm_stego.py extract --in stego.wav --out .pregrade_recovered.txt) >>"$dbg" 2>&1
    if [ $? -eq 0 ] && [ -f "$workdir/samples/message.txt" ]; then
        cmp -s "$workdir/.pregrade_recovered.txt" "$workdir/samples/message.txt"
        if [ $? -eq 0 ]; then
            pass "MESSAGE_RECOVERED"
        else
            fail "MESSAGE_RECOVERED" "recovered message differs"
        fi
    else
        fail "MESSAGE_RECOVERED" "extract command failed"
    fi
else
    fail "MESSAGE_RECOVERED" "script or stego missing"
fi

