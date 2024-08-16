function iterm2_print_user_vars() {
  DIR_STATUS=$(pwd)

  if [ -n "$VIRTUAL_ENV" ]; then
    VENV_STATUS=`basename "$VIRTUAL_ENV"`
    ENV_FOLDER="$VIRTUAL_ENV/src/$VENV_STATUS"

    if [ -f "$VIRTUAL_ENV/.project" ]; then
      ENV_FOLDER=`cat "$VIRTUAL_ENV/.project"`
      VENV_STATUS="$VENV_STATUS*"
    fi

    if [ -d "$ENV_FOLDER" ]; then
      if ! [ "$ENV_FOLDER" = "$DIR_STATUS" ]; then
        DIR_STATUS="@/$(grealpath --relative-to=$ENV_FOLDER $DIR_STATUS)"
      else
        DIR_STATUS="@"
      fi
    else
      if ! [ "$VIRTUAL_ENV/src" = "$DIR_STATUS" ]; then
        DIR_STATUS="@/$(grealpath --relative-to=$VIRTUAL_ENV/src $DIR_STATUS)"
      else
        DIR_STATUS="@"
      fi
    fi
    VENV_STATUS="$VENV_STATUS"
  else
    VENV_STATUS=""
    if ! [ "$DIR_STATUS" = "/Users/$USER" ]; then
      DIR_STATUS="~/$(grealpath --relative-to=/Users/$USER $DIR_STATUS)"
    else
      DIR_STATUS="~"
    fi
  fi

  IS_IN_GIT=$(git rev-parse --is-inside-work-tree 2> /dev/null)
  if [ "$IS_IN_GIT" = "true" ]; then
    GIT_BRANCH_STATUS=$(git rev-parse --abbrev-ref HEAD)
  else
    GIT_BRANCH_STATUS=""
  fi

  # iterm2_set_user_var virtualEnv "$VENV_STATUS"
  # iterm2_set_user_var currDir "$DIR_STATUS"

  CUSTOM_DISPLAY_PATH="$DIR_STATUS"

  if [ -n "$VENV_STATUS" ]; then
    CUSTOM_DISPLAY_PATH="$CUSTOM_DISPLAY_PATH - $VENV_STATUS"
  fi
  if [ -n "$GIT_BRANCH_STATUS" ]; then
    CUSTOM_DISPLAY_PATH="$CUSTOM_DISPLAY_PATH ($GIT_BRANCH_STATUS)"
  fi

  export VENV_STATUS="$VENV_STATUS"
  export GIT_BRANCH_STATUS="$GIT_BRANCH_STATUS"
  export DIR_STATUS="$DIR_STATUS"
  export CUSTOM_DISPLAY_PATH="$CUSTOM_DISPLAY_PATH"

  print -Pn "\e]1;$CUSTOM_DISPLAY_PATH\a"
}
precmd_functions+=(iterm2_print_user_vars)
