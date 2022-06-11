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

  wget -O "${deb_dest}" "${SYS_CONF[erlang_dl_link]}"
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
    common.log "${phase}" "installing (${ext})..."
    su - "${CONF[target_user]}" -c "code --force --install-extension ${ext}"
  done
}

elixir.install
elixir.config_vscode
