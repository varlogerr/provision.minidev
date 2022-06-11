[[ $(id -u) -ne 0 ]] && {
  echo "Must run as sudo or root!" >&2
  exit 1
}

__iife_validate_empty_conf() {
  unset __iife_validate_empty_conf

  declare -A kv=(
    [target_user]="Target user is not defined!"
    [target_user_home]="User ${CONF[target_user_home]} doesn't have a home!"
  )

  for i in "${!kv[@]}"; do
    [[ -z "${CONF[target_user]}" ]] \
      && echo "${kv[${i}]}" >&2 && return 0
  done

  return 1
} && __iife_validate_empty_conf && exit 1
