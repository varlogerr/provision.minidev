#
# if you don't want PS1 changed to PS1_GIT, paste
# ```
# export PS1_GIT="${PS1}"
# ```
# before the current script is sourced, or
# ```
# PS1="${PS1_ORIGIN}"
# ```
# after the current script is sourced
#
__iife() {
  unset __iife
  local git_prompt_branch_format=' :\[\033[01;33m\]%s\[\033[00m\]'
  local git_prompt_prefix='\u@\h \w'
  local git_prompt_branch="\$( \
    typeset -f __git_ps1 > /dev/null 2>&1 && \
    __git_ps1 \"${git_prompt_branch_format}\" \
  )"

  PS1_ORIGIN="${PS1_ORIGIN:-${PS1}}"
  PS1_GIT="${PS1_GIT:-$(
    printf '[\[\033[01;32m\]%s\[\033[00m\]%s] ' \
      "${git_prompt_prefix}" \
      "${git_prompt_branch}" \
  )}"
  PS1="${PS1_GIT}"
} && __iife
