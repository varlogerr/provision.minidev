git.gitconfig() {
  local dest="${CONF[target_user_home]}/.gitconfig"

  common.log "git:config" "configuring .gitconfig ..."

  sed -e 's/{{name}}/'${CONF[git_user]}'/g' \
      -e 's/{{email}}/'${CONF[git_email]}'/g' \
    "${PROJECT_DIR}/inc/tpl/git/.gitconfig" > "${dest}"
}

git.config_ps1() {
  local dest="${CONF[target_user_home]}/${SYS_CONF[bashrcd_prefix]}/0100-git-ps1.sh"
  local dest_dir="$(dirname "${dest}")"
  local source_cmd='for f in "${dest_dir}"/*.sh; do . "${f}"; done'
  local bashrc_path="${CONF[target_user_home]}/.bashrc"

  common.log "git:config" "configuring git PS1 ..."

  mkdir -p "${dest_dir}"
  cp "${PROJECT_DIR}/inc/tpl/git/ps1.sh" "${dest}"

  ! grep -F "${source_cmd}" "${bashrc_path}" \
    && echo "# source ${SYS_CONF[bashrcd_prefix]}/*.sh files" \
      $'\n'"${source_cmd}" >> "${bashrc_path}"
}

git.gitconfig
git.config_ps1
