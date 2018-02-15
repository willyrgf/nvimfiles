#!/bin/sh
# @author Willy Romao
# @version 0.5 02/2018
# @email willyr.goncalves@gmail.com

XDG_CONFIG_HOME="$HOME/.config/nvim"
BASEDIR="$(dirname $0)"
REQUERIED_PROGRAMS="nvim git"
NULL="/dev/null"

_check_if_progms_installed ()
{
  [ -z "${REQUERIED_PROGRAMS}" ] && exit 1

  for p in ${REQUERIED_PROGRAMS}; do
    if ! type "$p" 2&>1 $NULL ; then
      echo "Program required: ${p} not found;"
      return 1
    fi
  done
  return 0
}

_install_nvim()
{
  [ ! -d "${XDG_CONFIG_HOME}" ] && mkdir -p "${XDG_CONFIG_HOME}"
  mv "${BASEDIR}"/vimrcs/*.vim "${XDG_CONFIG_HOME}/"
  nvim +PlugInstall +qall
}

_check_if_progms_installed "${REQUERIED_PROGRAMS}" || exit 1

_install_nvim || exit 1

