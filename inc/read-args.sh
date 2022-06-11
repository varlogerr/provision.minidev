__iife_read_stop_args() {
  unset __iife_read_stop_args

  while :; do
    [[ -z "${1+x}" ]] && break

    case "${1}" in
      -\?|-h|--help )   sed 's/{{tool_name}}/'${TOOL_NAME}'/g' "${PROJECT_DIR}/inc/tpl/help.txt"; return 0;;
      gen-conf      )   cat "${PROJECT_DIR}/inc/tpl/conf.sh"; return 0;;
    esac
  done

  return 1
} && __iife_read_stop_args "${@}" && exit
