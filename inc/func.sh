cmd_target() {
  su - "${CONF[target_user]}" -c "${1}"
}
