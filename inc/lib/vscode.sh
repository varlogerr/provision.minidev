vscode.install() {
  local phase="vscode"
  local gpg_file=/usr/share/keyrings/microsoft.gpg
  which code > /dev/null && {
    common.log "${phase}" "skipping installation (installed)"
    return
  }

  common.log "${phase}" "installing ..."
  wget -q -O- "${CONF[ms_gpg_link]}" \
    | gpg --dearmor > "${gpg_file}"
  echo "deb [arch=amd64 signed-by=${gpg_file}] ${CONF[vscode_repo_link]} stable main" \
    > /etc/apt/sources.list.d/vscode.list
  common.update_repository
  apt install -y code
}

vscode.config_editorconfig() {
  vscode._install_ext "vscode" "editorconfig.editorconfig"
}

vscode._install_ext() {
  local phase="${1}"
  local exts="${2}"

  while read -r ext; do
    [[ -z "${ext}" ]] && continue
    common.log "${phase}" "installing vscode extension (${ext})..."
    cmd_target "code --force --install-extension ${ext}"
  done <<< "${exts}"
}

vscode.install
vscode.config_editorconfig
