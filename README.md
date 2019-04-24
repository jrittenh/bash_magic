# Self-refreshing bash shell

This repo contains a `.bashrc` file that self-refreshes, based on changes to
files stored in `~/.bash.d/`. At launch, every file in the directory is sourced.
Each time a command is entered, the prompt checks for new or updated files and,
if any are found, it sources them. This works across multiple sessions.

## Installation

First, clone this repository to `~/.bash.d/`.

Second, run one of the following options:

1. To install safely, run the following commands:

    export BACKUP_DIR="~/.bash_backup_`date +%Y%m%d`"
    mkdir $BACKUP_DIR
    mv ~/.bash_profile $BACKUP_DIR/bash_profile && ln -s ~/.bash.d/profile ~/.bash_profile && mv ~/.bashrc $BACKUP_DIR/bashrc && ln -s ~/.bash.d/rc ~/.bashrc

2. To install destructively, run the following command:
    rm ~/.bash_profile && ln -s ~/.bash.d/profile ~/.bash_profile && rm ~/.bashrc && ln -s ~/.bash.d/rc ~/.bashrc
