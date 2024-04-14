#!/bin/bash
set -e -o pipefail -o xtrace

../run-in-separate-pgrp --forward-signals-to-group --print-signals bash -c "sleep 100 & sleep 200" &
pid=$!

sleep 0.5
(pstree -ap 2>/dev/null || pstree) | grep -E "perl|sleep" | grep -v grep

kill -SIGINT $pid

sleep 0.5
if kill -0 $pid 2>/dev/null; then
  echo "Process $pid is still alive"
  exit 1
fi

set +e
wait $pid
code=$?
set -e
test "$code" -eq 143 # 128 + SIGTERM

echo "ok"
