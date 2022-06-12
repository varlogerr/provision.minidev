#!/usr/bin/env bash

PROJECT_DIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
TOOL_NAME="$(basename "${BASH_SOURCE[0]}")"

INVALID_ARGS=()

for f in \
  func \
  tpl/conf \
  read-args \
  extend-conf \
  validation \
  lib/common \
  lib/git \
  lib/tmux \
  lib/vscode \
  lib/elixir \
  lib/nodejs \
  lib/cleanup \
; do . "${PROJECT_DIR}/inc/${f}.sh"; done
