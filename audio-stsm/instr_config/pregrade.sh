#!/bin/bash
: <<'END'
Pregrade script for the STSM embedding lab.
It rebuilds grading state from the learner's current files so checkwork
reflects the actual task progress instead of stale markers.
END

homedir=$1
destdir=$2
dbg=/tmp/audio-stsm-pregrade.log

workdir="$homedir/$destdir/stego"
resultdir="$homedir/$destdir/.local/result"
result="$resultdir/stsm_check.txt"
marker="$workdir/.analysis_done"

mkdir -p "$resultdir"
: > "$result"
echo "pregrade for $homedir/$destdir" > "$dbg"

pass() { echo "PASS_$1" >> "$result"; }
fail() { echo "FAIL_$1: $2" >> "$result"; }

if [ -s "$workdir/message.txt" ]; then
    pass "MESSAGE_CREATED"
else
    fail "MESSAGE_CREATED" "message.txt missing or empty"
fi

if [ -s "$workdir/cover.wav" ]; then
    pass "COVER_CREATED"
else
    fail "COVER_CREATED" "cover.wav missing"
fi

if [ -s "$workdir/stego.wav" ]; then
    pass "STEGO_CREATED"
else
    fail "STEGO_CREATED" "stego.wav missing"
fi

if [ -s "$marker" ]; then
    pass "SAMPLES_MODIFIED"
else
    fail "SAMPLES_MODIFIED" "analysis step not completed"
fi
