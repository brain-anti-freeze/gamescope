#!/usr/bin/env bash
SETCAP=${1:?}
BINDIR=${2:?}
EXE=${3:?}
: ${MESON_INSTALL_PREFIX:?}

[ -v MESON_INSTALL_QUIET ] && exec >/dev/null

# Set CAP_SYS_NICE on binary when installing as root
if [[ $EUID -eq 0 ]]; then
    $SETCAP 'CAP_SYS_NICE=eip' $MESON_INSTALL_PREFIX/$BINDIR/$EXE
    $SETCAP -v 'CAP_SYS_NICE=eip' $MESON_INSTALL_PREFIX/$BINDIR/$EXE
else
    echo -e "Enable high-priority compute and threads with:\n"
    echo -e "\tsudo ${SETCAP} 'CAP_SYS_NICE=eip' ${MESON_INSTALL_PREFIX}/${BINDIR}/${EXE}"
fi