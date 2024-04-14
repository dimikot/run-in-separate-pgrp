#!/bin/bash
set -e -o pipefail -o xtrace

res=$(echo "dummy" | ../run-in-separate-pgrp cat)
test "$res" == "dummy"

echo "ok"
