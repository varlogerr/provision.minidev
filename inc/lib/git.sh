git.gitconfig() {
  local dest="${CONF[target_user_home]}/.gitconfig"

  common.log "git:config" "configuring .gitconfig ..."

  cmd_target "cp '${PROJECT_DIR}/inc/tpl/git/.gitconfig' '${dest}'"

  sed -i "s/{{name}}/${CONF[git_user]}/g" "${dest}"
  sed -i "s/{{email}}/${CONF[git_email]}/g" "${dest}"
}

git.config_ps1() {
  local confd="${CONF[target_user_home]}/${SYS_CONF[bashrcd_prefix]}"
  local dest_file="${CONF[target_user_home]}/${SYS_CONF[bashrcd_prefix]}/0100-git-ps1.sh"
  local source_cmd="for f in '${confd}'/*.sh; do . \"\${f}\" > /dev/null; done"
  local bashrc_path="${CONF[target_user_home]}/.bashrc"

  common.log "git:config" "configuring git PS1 ..."

  while read -r cmd; do [[ -n "${cmd}" ]] && cmd_target "${cmd}"; done <<< "
    mkdir -p '${confd}'
    cp '${PROJECT_DIR}/inc/tpl/git/ps1.sh' '${dest_file}'
  "

  ! grep -qF "${source_cmd}" "${bashrc_path}" \
    && echo $'\n'"# source ${confd}/*.sh files" >> "${bashrc_path}" \
    && echo "${source_cmd}" >> "${bashrc_path}"
}

git.gitconfig
git.config_ps1
