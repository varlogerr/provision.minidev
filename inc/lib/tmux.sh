tmux.install() {
  local phase="tmux"

  tmux -V > /dev/null 2>&1 && {
    common.log "${phase}" "skipping installation (installed)"
    return
  }

  common.log "${phase}" "installing ..."

  apt install -y tmux
}

tmux.configure() {
  local phase="tmux:config"
  local dest_conffile="${CONF[target_user_home]}/.tmux.conf"
  local confdir="${CONF[target_user_home]}/${CONF[tmux_dir_prefix]}"
  local dest_settingsfile="${confdir}/settings.conf"
  local dest_pluginsfile="${confdir}/plugins.conf"
  local plugdir="${CONF[target_user_home]}/${CONF[tmux_plugins_prefix]}"
  local tpm_dir="${CONF[target_user_home]}/${CONF[tmux_tpm_prefix]}"

  common.log "${phase}" "configuring ..."

  while read -r cmd; do
    [[ -n "${cmd}" ]] && cmd_target "${cmd}"
  done <<< "
    cp '${PROJECT_DIR}/inc/tpl/tmux/.tmux.conf' '${dest_conffile}'
    mkdir -p '${confdir}'
    cp '${PROJECT_DIR}/inc/tpl/tmux/settings.conf' '${dest_settingsfile}'
    sed -i 's/{{settings_file}}/${dest_settingsfile//\//\\/}/g' '${dest_conffile}'
    sed -i 's/{{plugins_file}}/${dest_pluginsfile//\//\\/}/g' '${dest_conffile}'
  "

  [[ ! -d "${tpm_dir}" ]] && {
    cmd_target "git clone '${CONF[tmux_tpm_repo_url]}' '${tpm_dir}'"
  }

  local cs_before="$(sha256sum "${dest_pluginsfile}" 2> /dev/null | cut -d' ' -f1)"
  while read -r cmd; do
    [[ -n "${cmd}" ]] && cmd_target "${cmd}"
  done <<< "
    cp '${PROJECT_DIR}/inc/tpl/tmux/plugins.conf' '${dest_pluginsfile}'
    sed -i 's/{{plugins_dir}}/${plugdir//\//\\/}/g' '${dest_pluginsfile}'
    sed -i 's/{{tpm_bin}}/${tpm_dir//\//\\/}\/tpm/g' '${dest_pluginsfile}'
  "
  local cs_after="$(sha256sum "${dest_pluginsfile}" 2> /dev/null | cut -d' ' -f1)"

  [[ "${cs_before}" != "${cs_after}" ]] && {
    common.log "${phase}" "installing plugins ..."
    cmd_target "${tpm_dir}/scripts/install_plugins.sh"
  }
}

tmux.install_tmuxp() {
  local phase="tmuxp"

  tmuxp --version > /dev/null 2>&1 && {
    common.log "${phase}" "skipping installation (installed)"
    return
  }

  common.log "${phase}" "installing ..."

  apt install -y tmuxp
}

tmux.configure_tmuxp() {
  :
}

tmux.install
tmux.configure
tmux.install_tmuxp
