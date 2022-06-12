#!/usr/bin/env bash

PROJECT_DIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
TOOL_NAME="$(basename "${BASH_SOURCE[0]}")"

INVALID_ARGS=()

for f in \
  tpl/conf \
  read-args \
  extend-conf \
  validation \
  sys-conf \
  lib/common \
  lib/git \
  lib/tmux \
  lib/elixir \
; do . "${PROJECT_DIR}/inc/${f}.sh"; done
