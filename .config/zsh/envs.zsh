#!/usr/bin/env zsh

# Project-centric Python env management

: ${WORKON_HOME:="$HOME/code"}
ENV_REGISTRY_FILE="$WORKON_HOME/.envs"

_env_resolve() {
  local name="$1"
  if [[ -z "$name" ]]; then
    echo "Usage: _env_resolve ENVNAME" >&2
    return 1
  fi

  export ENV_NAME="$name"
  export ENV_ROOT="$WORKON_HOME/$name"

  local target=""
  if [[ -f "$ENV_REGISTRY_FILE" ]]; then
    local line
    line=$(grep -E "^${name}=" "$ENV_REGISTRY_FILE" 2>/dev/null | tail -n 1)
    if [[ -n "$line" ]]; then
      target="${line#*=}"
    fi
  fi

  if [[ -z "$target" ]]; then
    if [[ -d "$ENV_ROOT/src/$name" ]]; then
      target="$ENV_ROOT/src/$name"
    elif [[ -d "$ENV_ROOT/src" ]]; then
      target="$ENV_ROOT/src"
    else
      target="$ENV_ROOT"
    fi
  fi

  export ENV_TARGET="$target"
}

_env_registry_update() {
  local name="$1"
  local target="$2"

  mkdir -p -- "$WORKON_HOME"
  : >| "$ENV_REGISTRY_FILE".tmp

  if [[ -f "$ENV_REGISTRY_FILE" ]]; then
    while IFS= read -r line; do
      [[ -z "$line" ]] && continue
      [[ "$line" == \#* ]] && print -r -- "$line" >>"$ENV_REGISTRY_FILE".tmp && continue
      [[ "$line" == "${name}="* ]] && continue
      print -r -- "$line" >>"$ENV_REGISTRY_FILE".tmp
    done <"$ENV_REGISTRY_FILE"
  fi

  print -r -- "${name}=${target}" >>"$ENV_REGISTRY_FILE".tmp
  mv "$ENV_REGISTRY_FILE".tmp "$ENV_REGISTRY_FILE"
}

_env_registry_remove() {
  local name="$1"
  local found=0

  [[ ! -f "$ENV_REGISTRY_FILE" ]] && return 1

  : >| "$ENV_REGISTRY_FILE".tmp
  while IFS= read -r line; do
    [[ -z "$line" ]] && continue
    [[ "$line" == \#* ]] && print -r -- "$line" >>"$ENV_REGISTRY_FILE".tmp && continue
    if [[ "$line" == "${name}="* ]]; then
      found=1
      continue
    fi
    print -r -- "$line" >>"$ENV_REGISTRY_FILE".tmp
  done <"$ENV_REGISTRY_FILE"

  mv "$ENV_REGISTRY_FILE".tmp "$ENV_REGISTRY_FILE"
  return $found
}

_env_wrap_deactivate() {
  if (( $+functions[deactivate] )); then
    functions[__venv_original_deactivate]="$functions[deactivate]"
  fi
  deactivate() {
    if (( $+functions[__venv_original_deactivate] )); then
      __venv_original_deactivate "$@"
    fi
    unset ENV_NAME ENV_ROOT ENV_TARGET
  }
}
