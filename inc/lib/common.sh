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
  apt install -y wget curl vim
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

common.install_vscode() {
  local phase="vscode"
  which code > /dev/null && {
    common.log "${phase}" "skipping installation (installed)"
    return
  }

  common.log "${phase}" "installing ..."
  wget -q "${SYS_CONF[ms_gpg_link]}" -O- | apt-key add -
  add-apt-repository "deb [arch=amd64] ${SYS_CONF[vscode_repo_link]} stable main"
  common.update_repository
  apt install -y code
}

common.create_proj_dir() {
  local dest="${CONF[target_user_home]}/${CONF[projects_dir_prefix]}"
  common.log "projdir" "creating ${dest} ..."
  mkdir -p "${dest}"
}
