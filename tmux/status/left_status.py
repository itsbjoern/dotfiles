#!/usr/bin/env python

from segments import Segment, SegmentGroup, windows
from tmux import Tmux

if __name__ == "__main__":
    sessions = Tmux.get_sessions()
    status = SegmentGroup(
        [
            *[
                Segment(
                    f"{session.session_id}",
                    bgcolor="red" if session.active else "black",
                )
                for session in sessions
            ],
            windows.WindowsSegment(
                default_bg_color="color237",
                default_fg_color="color255",
                active_bg_color="color255",
                active_fg_color="color237",
            ),
        ],
        side="left",
    )
    print(status.build())
