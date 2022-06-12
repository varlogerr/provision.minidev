nodejs.install() {
  local phase="nodejs"

  node --version > /dev/null 2>&1 && {
    common.log "${phase}" "skipping installation (installed)"
    return
  }

  common.log "${phase}" "installing ..."

  curl -fsSL "${CONF[nodejs_preinstall_script_link]}" | bash -
  apt install -y nodejs
}

nodejs.config_vscode() {
  vscode._install_ext "nodejs" "
    leizongmin.node-module-intellisense
    dbaeumer.vscode-eslint
    eg2.vscode-npm-script
    jasonnutter.search-node-modules
    christian-kohler.npm-intellisense
  "
}

nodejs.create_proj_dir() {
  local dest="$(printf -- '%s/%s/%s' \
    "${CONF[target_user_home]}" \
    "${CONF[projects_dir_prefix]}" \
    "${CONF[nodejs_dir_prefix]}")"
  common.log "projdir" "creating ${dest} ..."
  cmd_target "mkdir -p '${dest}'"
}

nodejs.configure_tmuxp() {
  local phase="tmuxp:config"
  local dest_file="$(printf -- '%s/%s/%s.yml' \
    "${CONF[target_user_home]}" \
    "${CONF[tmux_tmuxp_dir_prefix]}" \
    "${CONF[nodejs_tmuxp_name]}")"
  local start_dir="$(printf -- '%s/%s/%s' \
    "${CONF[target_user_home]}" \
    "${CONF[projects_dir_prefix]}" \
    "${CONF[nodejs_dir_prefix]}")"

  common.log "${phase}" "configuring ..."
  tmux._cp_tmuxp_conf "${phase}" "${dest_file}" "${start_dir}"
}

nodejs.install
nodejs.config_vscode
nodejs.create_proj_dir
nodejs.configure_tmuxp
