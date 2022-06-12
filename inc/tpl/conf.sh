declare -A CONF=(
  [target_user]="${SUDO_USER:-$(logname)}"
  [git_user]=xxx
  [git_email]=na@3.bu
  [projects_dir_prefix]=Projects
  [elixir_dir_prefix]=elixir
  [nodejs_version]=16
  [nodejs_dir_prefix]=nodejs
)
