common.log() {
  local phase="${1}"
  local message="${2}"
  local format=

  printf -- '[%s:%s] %s\n' \
    "${TOOL_NAME^^}" "${phase^^}" "${message}"
}

common.update_repository() {
  common.log "repo" "updating ..."
  apt update
}

common.install_musts() {
  common.log "musts" "installing ..."
  apt install -y curl gnupg2 vim wget
}

common.install_git() {
  local phase="git"
  git --version > /dev/null 2>&1 && {
    common.log "${phase}" "skipping installation (installed)"
    return
  }

  common.log "${phase}" "installing ..."
  apt install -y git
}

common.install_chrome() {
  # in spiral 11 chrome doesn't start for some reason
  return

  local phase="chrome"
  local gpg_file=/usr/share/keyrings/google-chrome.gpg
  google-chrome-stable --version > /dev/null 2>&1 && {
    common.log "${phase}" "skipping installation (installed)"
    return
  }

  common.log "${phase}" "installing ..."
  wget -q -O- https://dl.google.com/linux/linux_signing_key.pub \
    | gpg --dearmor > "${gpg_file}"
  echo "deb [arch=amd64 signed-by=${gpg_file}] http://dl.google.com/linux/chrome/deb/ stable main" \
    > /etc/apt/sources.list.d/vscode.list
  common.update_repository
  apt install -y google-chrome-stable
}

common.install_vscode() {
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

common.config_vscode_editorconfig() {
  local ext=editorconfig.editorconfig
  common.log "${phase}" "installing (${ext})..."
  cmd_target "code --force --install-extension ${ext}"
}

common.create_proj_dir() {
  local dest="$(printf -- '%s/%s' \
    "${CONF[target_user_home]}" \
    "${CONF[projects_dir_prefix]}")"
  common.log "projdir" "creating ${dest} ..."
  cmd_target "mkdir -p '${dest}'"
}

common.update_repository

common.install_musts
common.install_git
common.install_chrome
common.install_vscode
common.config_vscode_editorconfig
common.create_proj_dir
