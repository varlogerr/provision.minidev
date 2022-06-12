# related to user configuration
CONF+=(
  [target_user_home]="$(eval echo ~"${CONF[target_user]}")"
)

# system specific configuration
CONF+=(
  [erlang_dl_link]=https://packages.erlang-solutions.com/erlang-solutions_2.0_all.deb
  [ms_gpg_link]=https://packages.microsoft.com/keys/microsoft.asc
  [vscode_repo_link]=https://packages.microsoft.com/repos/vscode
  [bashrcd_prefix]=.bashrc.d
  [tmux_tpm_repo_url]=https://github.com/tmux-plugins/tpm.git
  [tmux_dir_prefix]=.tmux
  [tmux_tmuxp_dir_prefix]=.tmuxp
  [tmux_tmuxp_main_name]=main
  [tmux_plugins_prefix]=.tmux/plugins
  [tmux_tpm_prefix]=.tmux/plugins/tpm
)
