#!/usr/bin/env python

from segments import Segment, SegmentGroup
from tmux import Tmux

if __name__ == "__main__":
    venv = Tmux.get_env_var("VENV_STATUS")
    git = Tmux.get_env_var("GIT_BRANCH_STATUS")
    curr_dir = Tmux.get_env_var("DIR_STATUS")

    status = SegmentGroup(
        [
            Segment(git, "green", "black", visible=git != ""),
            Segment(venv, "blue", visible=venv != ""),
            Segment(curr_dir, "red"),
        ],
        side="right",
    )
    print(status.build())
