#!/bin/bash

INSTALLDIR="$(pwd)"

echo "Checking for existing '~/.bashrc'"
if [[ -f ~/.bashrc ]]; then
    echo "Archiving existing '~/.bashrc'..."
    mv ~/.bashrc ~/.bashrc.$(date +%Y%m%dT%H%M%S)
    echo "Done."
fi

echo "Installing new '~/.bashrc'..."
ln -s ${INSTALLDIR}/rc ~/.bashrc
echo "Done."

echo "Checking for existing '~/.bash_profile'"
if [[ -f ~/.bash_profile ]]; then
    echo "Archiving existing '~/.bash_profile'..."
    mv ~/.bash_profile ~/.bash_profile.$(date +%Y%m%dT%H%M%S)
    echo "Done."
fi

echo "Installing new '~/.bash_profile'..."
ln -s ${INSTALLDIR}/profile ~/.bash_profile
echo "Done."

source ~/.bashrc
