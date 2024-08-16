
function mkvirtualenv --description "Create and activate a new virtual environment"
    argparse -N 1 -X 1 p/python= l/link= -- $argv
    or return

    if test (count $argv) -ne 1
        echo "Usage: mkvirtualenv ENVNAME"
        return 1
    end

    set VENV "$WORKON_HOME/$argv[1]"
    if test -d $VENV
        echo "Virtualenv \"$argv[1]\" already exists"
        return 1
    end

    set PYTHON_BIN $HOMEBREW_PREFIX/bin/python3
    if set -ql _flag_python
        set PYTHON_BIN $HOMEBREW_PREFIX/bin/$_flag_python
    end


    $PYTHON_BIN -m venv $VENV --upgrade-deps
    mkdir -p "$VENV/src"
    if set -ql _flag_link
        echo $(realpath $_flag_link) > "$VENV/.project"
    end

    source $VENV/bin/activate.fish
end
complete -c mkvirtualenv
complete -c mkvirtualenv -s p -l python -fra "$(ls $HOMEBREW_PREFIX/bin | grep -E "^python[0-9]\.[0-9][0-9]?\$" | sort | uniq)"
complete -c mkvirtualenv -s l -l link -r -d "Link to a project directory"



function rmvirtualenv --description "Remove a virtual environment"
    if test (count $argv) -ne 1
        echo "Usage: rmvirtualenv ENVNAME"
        return 1
    end

    set VENV "$WORKON_HOME/$argv[1]"
    if test ! -d $VENV
        echo "Virtualenv \"$argv[1]\" does not exist"
        return 1
    end

    read -l -P "Really delete \"$argv[1]\"? [y/N] " confirm

    switch $confirm
        case '' N n
        return 1
    end

    if test -n "$VIRTUAL_ENV"
        deactivate
    end
    cd
    rm -rf $VENV
end
complete -c rmvirtualenv -f
complete -c rmvirtualenv -ra "(ls $WORKON_HOME | sort | uniq)"



function workon --description "Activate a virtual environment"
    if test (count $argv) -ne 1
        echo "Usage: workon ENVNAME"
        return 1
    end

    set VENV "$WORKON_HOME/$argv[1]"
    if test ! -d $VENV
        echo "Virtualenv \"$argv[1]\" does not exist"
        return 1
    end

    source $VENV/bin/activate.fish
end
complete -c workon -f
complete -c workon -ra "(ls $WORKON_HOME | sort | uniq)"



function diff
    if test (count $argv) > 0
        set B "$argv[1]"
    else
        set B "development"
    end
    git merge-base $(git branch --show-current) $B | xargs git diff --ignore-all-space
end



function a
    if test -z "$VIRTUAL_ENV"
        echo "no active VIRTUAL ENV"
        return 1
    end

    # if .project file exists read content
    if test -e "$VIRTUAL_ENV/.project"
        set PROJECT $(cat $VIRTUAL_ENV/.project)
        if test -d "$PROJECT"
            cd "$PROJECT"
            return 0
        else
            echo "project directory '$PROJECT' does not exist"
            return 1
        end
    end

    if test ! -d "$VIRTUAL_ENV/src"
        mkdir "$VIRTUAL_ENV/src"
    end

    set -ug VIRTUAL_ENV_NAME $(basename $VIRTUAL_ENV)
    if test -d "$VIRTUAL_ENV/src/$VIRTUAL_ENV_NAME"
        cd "$VIRTUAL_ENV/src/$VIRTUAL_ENV_NAME"
    else
        cd "$VIRTUAL_ENV/src"
    end
end



function deactivate
    if test -z "$VIRTUAL_ENV"
        echo "no active VIRTUAL ENV"
        return 1
    end

    unset -ug VIRTUAL_ENV_NAME
    command deactivate
end



function set_venv_vars
    set CURR_DIR $(pwd)

    if test -n "$VIRTUAL_ENV"
        set VIRTUAL_ENV_STATUS_LABEL ""
        set VIRTUAL_ENV_REL_PATH ""
        set VIRTUAL_ENV_NAME $(basename $VIRTUAL_ENV)
        set VIRTUAL_ENV_SRC_FOLDER $VIRTUAL_ENV/src

        # Set label if we follow a project link
        if test -e $VIRTUAL_ENV/.project
            set VIRTUAL_ENV_SRC_FOLDER $(cat $VIRTUAL_ENV/.project)
            set VIRTUAL_ENV_STATUS_LABEL "*"
        else
            # Test if src folder should be adjusted to the virtualenv name
            if test -d $VIRTUAL_ENV_SRC_FOLDER/$VIRTUAL_ENV_NAME
                set VIRTUAL_ENV_SRC_FOLDER $VIRTUAL_ENV_SRC_FOLDER/$VIRTUAL_ENV_NAME
            end
        end

        # Set relative path
        if test $VIRTUAL_ENV_SRC_FOLDER != $CURR_DIR
            set VIRTUAL_ENV_REL_PATH "@/$(grealpath --relative-to=$VIRTUAL_ENV_SRC_FOLDER $CURR_DIR)"
        else
            set VIRTUAL_ENV_REL_PATH "@"
        end
    else
        set VIRTUAL_ENV_NAME ""
        if ! [ "$CURR_DIR" = "/Users/$USER" ];
            set VIRTUAL_ENV_REL_PATH "~/$(grealpath --relative-to=/Users/$USER $CURR_DIR)"
        else
            set VIRTUAL_ENV_REL_PATH "~"
        end
    end

    set IS_IN_GIT $(git rev-parse --is-inside-work-tree 2>/dev/null)
    if test "$IS_IN_GIT" = "true"
        set GIT_BRANCH_STATUS $(git rev-parse --abbrev-ref HEAD)
    else
        set GIT_BRANCH_STATUS ""
    end

    set_wezterm_var VIRTUAL_ENV_NAME $VIRTUAL_ENV_NAME
    set_wezterm_var VIRTUAL_ENV_STATUS_LABEL $VIRTUAL_ENV_STATUS_LABEL
    set_wezterm_var VIRTUAL_ENV_REL_PATH $VIRTUAL_ENV_REL_PATH
    set_wezterm_var GIT_BRANCH_STATUS $GIT_BRANCH_STATUS
end


function auto_workon
    if test -n "$VIRTUAL_ENV"
        return
    end

    set GIT_FOLDER $(git rev-parse --show-toplevel 2>/dev/null)
    if test -n "$GIT_FOLDER"
        if test -d "$WORKON_HOME/$GIT_FOLDER"
            workon $(basename "$GIT_FOLDER")
        end
    end
end