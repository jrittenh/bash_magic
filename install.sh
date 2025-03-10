#!/bin/bash

BASH_MAGIC_DIR=''
SYMLINK=false

while getopts 's' flag; do
    case "${flag}" in
        s) SYMLINK=true ;;
    esac
done

shift $(($OPTIND - 1))

if [[ -s "${HOME}/.bash_magic_dir" ]]; then
    source ${HOME}/.bash_magic_dir
else
    BASH_MAGIC_DIR="${1:-${HOME}/.bash.d}"
    BASH_MAGIC_DIR="${BASH_MAGIC_DIR/#\~/${HOME}}"
fi

echo "Installing to ${BASH_MAGIC_DIR}"
export BASH_MAGIC_DIR

mkdir -p ${BASH_MAGIC_DIR}
echo "export BASH_MAGIC_DIR=${BASH_MAGIC_DIR}" > ${HOME}/.bash_magic_dir

if [[ -n "$( ls -A ${BASH_MAGIC_DIR} )" ]]; then
    mkdir -p ${BASH_MAGIC_DIR}/archive
    find ${BASH_MAGIC_DIR} -maxdepth 1 -type f | xargs mv -t ${BASH_MAGIC_DIR}/archive/
fi

SRCDIR="$(dirname "$0")"

if [[ "${SYMLINK}" == "true" ]]; then
    echo "Symlink bash magic into ${BASH_MAGIC_DIR}"
    ln -s ${SRCDIR}/rc ${BASH_MAGIC_DIR}/00_rc
    ln -s ${SRCDIR}/profile ${BASH_MAGIC_DIR}/00_profile
    ln -s ${SRCDIR}/prompt ${BASH_MAGIC_DIR}/
    ln -s ${SRCDIR}/.prompt_command ${BASH_MAGIC_DIR}/
else
    echo "Copy bash magic into ${BASH_MAGIC_DIR}"
    cp ${SRCDIR}/rc ${BASH_MAGIC_DIR}/00_rc
    cp ${SRCDIR}/profile ${BASH_MAGIC_DIR}/00_profile
    cp ${SRCDIR}/prompt ${BASH_MAGIC_DIR}/
    cp ${SRCDIR}/.prompt_command ${BASH_MAGIC_DIR}/
fi

echo "ls -Al ${BASH_MAGIC_DIR}:"
ls -Al ${BASH_MAGIC_DIR}

echo "Checking for existing '~/.bashrc'"
if [[ -f ~/.bashrc ]] || [[ -L ~/.bashrc ]]; then
    echo "Archiving existing '~/.bashrc'..."
    mv ~/.bashrc ~/.bashrc.$(date +%Y%m%dT%H%M%S)
    echo "Done."
fi

echo "Installing new '~/.bashrc'..."
ln -s ${BASH_MAGIC_DIR}/00_rc ~/.bashrc
echo "Done."
ls -l ~/.bashrc

echo "Checking for existing '~/.bash_profile'"
if [[ -f ~/.bash_profile ]] || [[ -L ~/.bash_profile ]]; then
    echo "Archiving existing '~/.bash_profile'..."
    mv ~/.bash_profile ~/.bash_profile.$(date +%Y%m%dT%H%M%S)
    echo "Done."
fi

echo "Installing new '~/.bash_profile'..."
ln -s ${BASH_MAGIC_DIR}/00_profile ~/.bash_profile
echo "Done."
ls -l ~/.bash_profile

source ~/.bashrc

echo "Install complete and verified. Run"
echo "  source ~/.bashrc"
echo "in any open shells to initialize."
