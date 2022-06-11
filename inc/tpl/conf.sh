declare -A CONF=(
  [target_user]="${SUDO_USER:-$(logname)}"
  [projects_dir_prefix]="Projects"
  [elixir_dir_prefix]="elixir"
)
