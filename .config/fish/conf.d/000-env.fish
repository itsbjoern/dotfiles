set -Ux HOMEBREW_PREFIX (brew --prefix)

# set where virutal environments will live
set -Ux VIRTUAL_ENV_DISABLE_PROMPT 1
set -Ux WORKON_HOME $HOME/code
set -Ux PYTHONWARNINGS "ignore"

set -Ux EDITOR "vim"

# use the same directory for virtualenvs as virtualenvwrapper
set -Ux PIP_VIRTUALVENV_STATUS $WORKON_HOME

# makes pip detect an active virtualenv and install to it
set -Ux PIP_RESPECT_VIRTUALENV true

set -U fish_user_paths /usr/local/sbin $fish_user_paths
set -U fish_user_paths /usr/local/opt/node@16/bin $fish_user_paths
set -U fish_user_paths "/Applications/Visual Studio Code.app/Contents/Resources/app/bin" $fish_user_paths
set -U fish_user_paths "/Applications/WezTerm.app/Contents/MacOS" $fish_user_paths
set -U fish_user_paths /usr/local/opt/node@16/bin $fish_user_paths
set -U fish_user_paths $HOMEBREW_PREFIX/opt/python/libexec/bin $fish_user_paths
set -U fish_user_paths $PNPM_HOME $fish_user_paths

set -Ux PNPM_HOME "~/Library/pnpm"
