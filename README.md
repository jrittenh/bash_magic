# Self-refreshing bash shell

This repo contains a set of scripts to constantly refresh the shell environment.
At launch, every file in the install directory is sourced.  Every return on the
command prompt after, the prompt checks for files with newer modification times
from its environment and sources any that have changed.  This works across
multiple sessions.

## Installation

Clone the repository to where you would like the script installed; typically
`~/.bash.d`

Run `./install.sh` from the repository directory.
