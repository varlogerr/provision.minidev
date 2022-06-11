git.gitconfig() {
  local dest="${CONF[target_user_home]}/.gitconfig"

  common.log "git:config" "configuring .gitconfig ..."

  su - "${CONF[target_user]}" -c "cp '${PROJECT_DIR}/inc/tpl/git/.gitconfig' '${dest}'"

  sed -i "s/{{name}}/${CONF[git_user]}/g" "${dest}"
  sed -i "s/{{email}}/${CONF[git_email]}/g" "${dest}"
}

git.config_ps1() {
  local dest="${CONF[target_user_home]}/${SYS_CONF[bashrcd_prefix]}/0100-git-ps1.sh"
  local dest_dir="$(dirname "${dest}")"
  local source_cmd="for f in '${dest_dir}'/*.sh; do . \"${f}\"; done"
  local bashrc_path="${CONF[target_user_home]}/.bashrc"

  common.log "git:config" "configuring git PS1 ..."

  su - "${CONF[target_user]}" -c "mkdir -p '${dest_dir}'"
  su - "${CONF[target_user]}" -c "cp '${PROJECT_DIR}/inc/tpl/git/ps1.sh' '${dest}'"

  ! grep -qF "${source_cmd}" "${bashrc_path}" \
    && echo $'\n' "# source ${SYS_CONF[bashrcd_prefix]}/*.sh files" \
      $'\n' "${source_cmd}" >> "${bashrc_path}"
}

git.gitconfig
git.config_ps1
