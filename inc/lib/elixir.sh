elixir.install() {
  # erlang-dialyzer and erlang-edoc are required for vscode
  # ElixirLS extension
  local pkgs="
    elixir
    erlang-observer
  "
  local deb_dest=/tmp/erlang-solutions_2.0_all.deb
  local phase="elixir"

  elixir --version > /dev/null 2>&1 && {
    common.log "${phase}" "skipping installation (installed)"
    return
  }

  common.log "${phase}" "installing ..."

  wget -O "${deb_dest}" "${CONF[erlang_dl_link]}"
  dpkg -i "${deb_dest}"
  common.update_repository
  apt install -y ${pkgs}
  rm -f "${deb_dest}"
}

elixir.config_vscode() {
  local pkgs="erlang-dialyzer erlang-edoc"
  local exts="jakebecker.elixir-ls"
  local phase="vscode-ext:elixir"

  apt install -y ${pkgs}

  for ext in ${exts}; do
    common.log "${phase}" "installing (${ext}) ..."
    cmd_target "code --force --install-extension ${ext}"
  done
}

elixir.create_proj_dir() {
  local dest="$(printf -- '%s/%s/%s' \
    "${CONF[target_user_home]}" \
    "${CONF[projects_dir_prefix]}" \
    "${CONF[elixir_dir_prefix]}")"
  common.log "projdir" "creating ${dest} ..."
  cmd_target "mkdir -p '${dest}'"
}

elixir.configure_tmuxp() {
  local phase="tmuxp:config"
  local dest_file="$(printf -- '%s/%s/%s.yml' \
    "${CONF[target_user_home]}" \
    "${CONF[tmux_tmuxp_dir_prefix]}" \
    "${CONF[elixir_tmuxp_name]}")"
  local start_dir="$(printf -- '%s/%s/%s' \
    "${CONF[target_user_home]}" \
    "${CONF[projects_dir_prefix]}" \
    "${CONF[elixir_dir_prefix]}")"

  common.log "${phase}" "configuring ..."
  tmux._cp_tmuxp_conf "${phase}" "${dest_file}" "${start_dir}"
}

elixir.install
elixir.config_vscode
elixir.create_proj_dir
elixir.configure_tmuxp
