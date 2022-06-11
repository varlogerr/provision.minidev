#!/usr/bin/env bash

PROJECT_DIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
TOOL_NAME="$(basename "${BASH_SOURCE[0]}")"

for f in \
  tpl/conf \
  lib/common \
  lib/elixir \
  read-args \
  extend-conf \
  validation \
  global-conf \
; do . "${PROJECT_DIR}/inc/${f}.sh"; done

common.update_repository

common.install_musts
common.install_git
# common.config_git
common.install_vscode
common.create_proj_dir

elixir.install
elixir.config_vscode
