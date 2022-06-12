cleanup.cleanup() {
  common.log "cleanup" "cleaning ..."

  apt -y clean
  apt -y autoclean
  apt -y autoremove
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
}

cleanup.cleanup
